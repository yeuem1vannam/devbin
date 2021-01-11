# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Attach < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(output: $stdout)
        container_id, _err = run "docker-compose -f #{docker_compose_file} ps -q #{service_name}", chdir: root
        output.puts pastel.green(
          "Remember to use ",
          pastel.yellow.on_bright_black.bold("Ctrl + C"),
          " to detach from container ( Overrided Ctrl + P Ctrl + Q to work with VSCode )"
        )
        pid = Process.fork do
          exec "docker attach #{container_id.strip} --detach-keys='ctrl-c'"
        end
        Process.wait pid
        output.puts pastel.yellow.bold("OK")
      end
    end
  end
end
