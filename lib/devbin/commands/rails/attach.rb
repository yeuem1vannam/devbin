# frozen_string_literal: true

require_relative "../../command"

module Devbin
  module Commands
    class Rails
      class Attach < Devbin::Command
        def initialize(app_name, options)
          @app_name = app_name
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          container_id, _err = run "docker-compose ps -q #{@app_name}", chdir: docker_pwd
          puts pastel.green(
            "Remember to use ",
            pastel.yellow.on_bright_black.bold("Ctrl + C"),
            " to detach from container ( Overrided Ctrl + P Ctrl + Q to work with VSCode )"
          )
          pid = Process.fork {
            exec "docker attach #{container_id.strip} --detach-keys='ctrl-c'"
          }
          Process.wait pid
          output.puts "OK"
          exit 0
        end
      end
    end
  end
end
