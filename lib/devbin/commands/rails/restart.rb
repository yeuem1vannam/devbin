# frozen_string_literal: true

require_relative "../../command"

module Devbin
  module Commands
    class Rails
      class Restart < Devbin::Command
        def initialize(app_name, options)
          @app_name = app_name
          @options = options || {}
        end

        def execute(input: $stdin, output: $stdout)
          require_relative "stop"
          Devbin::Commands::Rails::Stop.new(
            @app_name,
            {all: false, sync: @options[:sync]}
          ).execute

          require_relative "server"
          Devbin::Commands::Rails::Server.new(
            @app_name,
            @options.slice(:detach, :sync)
          ).execute
          output.puts pastel.yellow.bold("OK")
        end
      end
    end
  end
end
