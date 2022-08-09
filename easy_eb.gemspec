# frozen_string_literal: true

require_relative "lib/easy_eb/version"

Gem::Specification.new do |spec|
  spec.name = "easy_eb"
  spec.version = EasyEb::VERSION
  spec.authors = ["Kaleb Lape"]
  spec.email = ["kaleb.lape@gmail.com"]

  spec.summary = "Make Elastic Beanstalk easier to work with."
  spec.description = "Ungerware is a software development shop crafting solutions for iOS, Android, and Web. Specializing in IoT and other hardware initiatives, Ungerware uses the latest technologies to develop best-in-class business and consumer apps."
  spec.homepage = "https://unger-ware.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Ungerware/easy_eb.git"
  spec.metadata["changelog_uri"] = "https://github.com/Ungerware/easy_eb/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
