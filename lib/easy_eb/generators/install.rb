require "thor/group"

module EasyEb
  module Generators
    class Install < Thor::Group
      include Thor::Actions

      def self.source_root
        "#{File.dirname(__FILE__)}/template"
      end

      def copy_helper_scripts
        copy_file "bin/ebenv"
        copy_file "bin/eb-exec-hook"

        chmod "bin/ebenv", 777
        chmod "bin/eb-exec-hook", 777
      end
    end
  end
end
