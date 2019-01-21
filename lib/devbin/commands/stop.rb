# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Stop < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        if @options[:sync]
          run "docker-sync stop -c #{docker_sync_file}", chdir: root
        end
        if @options[:all]
          run "docker-compose -f #{docker_compose_file} stop", chdir: root
        else
          run "docker-compose -f #{docker_compose_file} stop #{service_name}", chdir: root
        end
        output.puts pastel.yellow.bold("OK")
      end
    end
  end
end
