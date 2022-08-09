require "thor"

module EasyEb
  class CLI < Thor
    desc "create-environment TARGET", "Creates an EB environment for the target stack (e.g. staging or production)"
    option :slug, type: :string
    def create_environment(target)
      EasyEb::Environment.create!(target: target, **options.transform_keys(&:to_sym))
    end
  end
end
