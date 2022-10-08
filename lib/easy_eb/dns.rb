require "json"

module EasyEb
  # Data sourced from https://docs.aws.amazon.com/general/latest/gr/elasticbeanstalk.html
  HOSTED_ZONES_BY_REGION = {
    "us-east-1" => "Z117KPS5GTRQ2G",
    "us-east-2" => "Z14LCN19Q5QHIC",
    "us-west-1" => "Z1LQECGX5PH1X",
    "us-west-2" => "Z38NKT9BP95V3O",
    "eu-west-2" => "Z1GKAAAUGATPF1"
  }

  class Dns
    def self.create!(environment:, domain:, region: nil)
      root_domain = /(?<root>\w+\.\w+)\.?$/.match(domain)&.then { |results| results[:root] }
      raise "Must supply valid domain name." unless root_domain

      region_flag = region && " --region #{region}"

      puts hosted_zones = JSON.parse(`aws route53 list-hosted-zones`)
      hosted_zone = hosted_zones.fetch("HostedZones").find { |zone| zone.fetch("Name").start_with?(root_domain) }
      hosted_zone_id = hosted_zone["Id"]

      puts environments = JSON.parse(`aws#{region_flag} elasticbeanstalk describe-environments --environment-names #{environment}`)
      environment_cname = environments.dig("Environments", 0, "CNAME")
      environment_region = /(?<region>[1-9a-z-]+).elasticbeanstalk.com$/.match(environment_cname)[:region]

      change_batch = {
        Comment: "Point #{domain} to Elastic Beanstalk Environment #{environment}",
        Changes: [
          {
            Action: :UPSERT,
            ResourceRecordSet: {
              Name: domain,
              Type: :A,
              AliasTarget: {
                HostedZoneId: HOSTED_ZONES_BY_REGION[environment_region],
                DNSName: environment_cname,
                EvaluateTargetHealth: false
              }
            }
          }
        ]
      }

      system(
        "aws route53 change-resource-record-sets --hosted-zone-id #{hosted_zone_id} --change-batch '#{change_batch.to_json}'".tap do |command|
          puts "Running… \"#{command}\""
        end
      )
    end
  end
end
