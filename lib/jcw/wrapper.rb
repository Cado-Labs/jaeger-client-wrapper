# frozen_string_literal: true

require_relative "config"

module JCW
  module Wrapper
    class << self
      def config
        @config ||= Config.new
      end

      def configure
        yield config
        Init.call
      end
    end
  end
end

require_relative "init"
require_relative "subscriber"
require_relative "http_tracer"
require_relative "rack_tracer"
require_relative "logger"
require_relative "logger_extension"

begin
  require "gruf"

  require_relative "interceptors/gruf/client"
  require_relative "interceptors/gruf/server"
  require_relative "interceptors/gruf/hpack"
rescue LoadError
  :noop
end
