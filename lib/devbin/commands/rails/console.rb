# frozen_string_literal: true

require_relative "../../command"

module Devbin
  module Commands
    class Rails
      class Console < Devbin::Command
        def initialize(app_name, options)
          @app_name = app_name
          @options = options
        end

        def execute(output: $stdout)
          Dir.chdir(docker_pwd) do
            pid = Process.fork do
              exec "docker-compose exec #{@app_name} bundle exec rails c"
            end
            Process.wait pid
            output.puts pastel.yellow.bold("OK")
            exit 0
          end
        end
      end
    end
  end
end
