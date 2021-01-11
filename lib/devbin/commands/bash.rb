# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Bash < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(output: $stdout)
        Dir.chdir root do
          pid = Process.fork do
            exec "docker-compose -f #{docker_compose_file} exec #{service_name} bash"
          end
          Process.wait pid
          output.puts pastel.yellow.bold("OK")
          exit 0
        end
      end
    end
  end
end
