# frozen_string_literal: true

require "thor"

module Devbin
  module Commands
    class Rails < Thor

      namespace :rails

      map "s" => "server"
      map "c" => "console"
      map "a" => "attach"

      desc "server [APP_NAME]", "Start the Rails server"
      method_option :help, aliases: "-h", type: :boolean,
        desc: "Display usage information"
      method_option :detach, aliases: "-d", type: :boolean, required: false, default: false,
        desc: "Start the server with detached mode"
      method_option :sync, aliases: "-s", type: :boolean, default: true,
        desc: "Start the docker-sync also"
      def server(app_name)
        if options[:help]
          invoke :help, ["server"]
        else
          require_relative "rails/server"
          Devbin::Commands::Rails::Server.new(app_name, options).execute
        end
      end

      desc "attach APP_NAME", "Attach to the rails server"
      method_option :help, aliases: "-h", type: :boolean,
        desc: "Display usage information"
      def attach(app_name)
        if options[:help]
          invoke :help, ["attach"]
        else
          require_relative "rails/attach"
          Devbin::Commands::Rails::Attach.new(app_name, options).execute
        end
      end

      desc "console APP_NAME", "Start the rails console"
      method_option :help, aliases: "-h", type: :boolean,
        desc: "Display usage information"
      def console(app_name)
        if options[:help]
          invoke :help, ["console"]
        else
          require_relative "rails/console"
          Devbin::Commands::Rails::Console.new(app_name, options).execute
        end
      end

      desc "stop APP_NAME", "Stop the rails application"
      method_option :help, aliases: "-h", type: :boolean,
        desc: "Display usage information"
      method_option :all, aliases: "-a", type: :boolean, default: false,
        desc: "Stop all applications"
      method_option :sync, aliases: "-s", type: :boolean, default: true,
        desc: "Stop the docker-sync also"
      def stop(app_name = "")
        if options[:help]
          invoke :help, ["stop"]
        else
          require_relative "rails/stop"
          Devbin::Commands::Rails::Stop.new(app_name, options).execute
        end
      end

      desc "restart APP_NAME", "Restart the application"
      method_option :help, aliases: "-h", type: :boolean,
        desc: "Display usage information"
      method_option :detach, aliases: "-d", type: :boolean, default: false,
        desc: "Restart the server with detached mode"
      method_option :sync, aliases: "-s", type: :boolean, default: false,
        desc: "Restart the docker-sync also"
      def restart(app_name)
        if options[:help]
          invoke :help, ["restart"]
        else
          require_relative "rails/restart"
          Devbin::Commands::Rails::Restart.new(app_name, options).execute
        end
      end

      desc "off", "Close all active containers and go home"
      method_option :help, aliases: "-h", type: :boolean,
        desc: "Display usage information"
      def off(*)
        if options[:help]
          invoke :help, ["off"]
        else
          require_relative "rails/off"
          Devbin::Commands::Rails::Off.new(options).execute
        end
      end
    end
  end
end
