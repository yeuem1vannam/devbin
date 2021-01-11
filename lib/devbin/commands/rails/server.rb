# frozen_string_literal: true

require_relative "../../command"

module Devbin
  module Commands
    class Rails
      class Server < Devbin::Command
        def initialize(app_name, options)
          @app_name = app_name
          @options = options
        end

        def execute(output: $stdout)
          require "tty-command"
          if @options[:sync]
            begin
              run "docker-sync start", chdir: docker_sync_pwd
            rescue TTY::Command::ExitError => e
              unless e.message =~ /warning\s+docker-sync\salready\sstarted\sfor\sthis\sconfiguration/
                raise e
              end
            end
          end
          run "docker-compose up -d #{@app_name}", chdir: docker_pwd
          unless @options[:detach]
            require_relative "attach"
            Devbin::Commands::Rails::Attach.new(@app_name, {}).execute
          end
          output.puts pastel.yellow.bold("OK")
        end
      end
    end
  end
end
