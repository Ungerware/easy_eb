require "json"
require "yaml"

module EasyEb
  class Environment
    SLUGS = JSON.parse(File.read("#{__dir__}/firstNames.json")).fetch("firstNames")

    def self.create!(target:, slug: SLUGS.sample)
      puts target, slug
      eb_config = YAML.safe_load(File.read(".elasticbeanstalk/config.yml"))
      application_name = eb_config.dig("global", "application_name")

      stack_name = "#{application_name}-#{target}"

      environment_name = "#{stack_name}-#{slug}"

      if environment_name.length > 40
        raise "Failed to create a valid Elastic Beanstalk environment with name '#{environment_name}'. Must be 40 characters or less."
      end

      system("eb config put #{target}", exception: true)
      system("eb create #{environment_name} --cfg #{target}", exception: true)

      puts("Success! Now you may want to run elastic beanstalk commands like this:")
      puts("eb deploy #{environment_name}")
    end
  end
end
