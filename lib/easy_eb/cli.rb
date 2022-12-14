require "thor"

module EasyEb
  class CLI < Thor
    desc "create-environment TARGET [--slug SLUG]", "Creates an EB environment for the target stack (e.g. staging or production) with a unique slug appended"
    option :slug, type: :string
    option :region, type: :string
    def create_environment(target)
      EasyEb::Environment.create!(target: target, **options.transform_keys(&:to_sym))
    end

    desc "dns ENVIRONMENT DOMAIN", "Updates or creates a DNS record to point at the specified environment"
    option :slug, type: :string
    option :region, type: :string
    def dns(environment, domain)
      EasyEb::Dns.create!(environment: environment, domain: domain, **options.transform_keys(&:to_sym))
    end

    desc "install", "Install essential eb helpers to be checked into your repo"
    def install
      EasyEb::Generators::Install.start
    end

    desc "ssh [--environment ENVIRONMENT] [COMMAND]", "Intelligent ssh for elastic beanstalk"
    option :environment, type: :string
    option :region, type: :string
    option :ssh, type: :string
    option :eb_flags, type: :string
    option :env_command, type: :string
    def ssh(*command)
      EasyEb::Ssh.start!(command: command.any? ? command.join(" ") : nil, **options.transform_keys(&:to_sym))
    end
  end
end
