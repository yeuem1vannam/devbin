# frozen_string_literal: true

require_relative "../../command"

module Devbin
  module Commands
    class Rails
      class Stop < Devbin::Command
        def initialize(app_name, options)
          @app_name = app_name
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          if @options[:sync]
            run "docker-sync stop", chdir: docker_sync_pwd
          end
          if @options[:all]
            run "docker-compose stop", chdir: docker_pwd
          else
            run "docker-compose stop #{@app_name}", chdir: docker_pwd
          end
          output.puts pastel.yellow.bold("OK")
        end
      end
    end
  end
end
