# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Bash < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        Dir.chdir root do
          pid = Process.fork {
            exec "docker-compose -f #{docker_compose_file} exec #{@app_name} bash"
          }
          Process.wait pid
          output.puts pastel.yellow.bold("OK")
          exit 0
        end
      end
    end
  end
end
