# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Start < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        require "tty-command"
        if @options[:sync]
          begin
            run "docker-sync start -c #{docker_sync_file}", chdir: root
          rescue TTY::Command::ExitError => e
            unless e.message =~ /warning\s+docker-sync\salready\sstarted\sfor\sthis\sconfiguration/
              raise e
            end
          end
        end
        run "docker-compose -f #{docker_compose_file} up -d #{service_name}", chdir: root
        output.puts pastel.yellow.bold("OK")
      end
    end
  end
end
