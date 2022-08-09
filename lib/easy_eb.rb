# frozen_string_literal: true

require_relative "easy_eb/environment"
require_relative "easy_eb/generators/install"
require_relative "easy_eb/ssh"
require_relative "easy_eb/version"

module EasyEb
  class Error < StandardError; end
end
