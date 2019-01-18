# frozen_string_literal: true

require "thor"

module Devbin
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    class_option :help, aliases: "-h", type: :boolean,
      desc: "Display usage information"

    desc "version", "devbin version"
    def version
      require_relative "version"
      puts "v#{Devbin::VERSION}"
    end
    map %w(--version -v) => :version

    desc "up [APP_NAME]", "Start the application"
    method_option :detach, aliases: "-d", type: :boolean, required: false, default: false,
      desc: "Start the application with detached mode"
    method_option :sync, aliases: "-s", type: :boolean, default: true,
      desc: "Start the docker-sync also"
    def up(app_name)
      if options[:help]
        invoke :help, ["up"]
      else
        require_relative "commands/up"
        Devbin::Commands::Up.new(app_name, options).execute
      end
    end

    desc "attach APP_NAME", "Attach to the application"
    def attach(app_name)
      if options[:help]
        invoke :help, ["attach"]
      else
        require_relative "commands/attach"
        Devbin::Commands::Attach.new(app_name, options).execute
      end
    end

    desc "start [APP_NAME]", "Start the application"
    method_option :sync, aliases: "-s", type: :boolean, default: true,
      desc: "Start the docker-sync also"
    def start(app_name)
      if options[:help]
        invoke :help, ["start"]
      else
        require_relative "commands/start"
        Devbin::Commands::Start.new(app_name, options).execute
      end
    end

    desc "stop APP_NAME", "Stop the rails application"
    method_option :all, aliases: "-a", type: :boolean, default: false,
      desc: "Stop all applications"
    method_option :sync, aliases: "-s", type: :boolean, default: true,
      desc: "Stop the docker-sync also"
    def stop(app_name = "")
      if options[:help]
        invoke :help, ["stop"]
      else
        require_relative "commands/stop"
        Devbin::Commands::Stop.new(app_name, options).execute
      end
    end

    desc "restart APP_NAME", "Restart the application"
    # method_option :all, aliases: "-a", type: :boolean, default: false,
    #   desc: "Restart all applications"
    method_option :sync, aliases: "-s", type: :boolean, default: true,
      desc: "Restart the docker-sync also"
    def restart(app_name)
      if options[:help]
        invoke :help, ["restart"]
      else
        require_relative "commands/restart"
        Devbin::Commands::Restart.new(app_name, options).execute
      end
    end

    desc "bash APP_NAME", "Attach to bash for the given app"
    def bash(app_name)
      if options[:help]
        invoke :help, ["bash"]
      else
        require_relative "commands/bash"
        Devbin::Commands::Bash.new(app_name, options).execute
      end
    end
    map %w(sh) => :bash

    desc "off", "Close all active containers and go home"
    method_option :yes, aliases: "-y", type: :boolean, default: false,
      desc: "No ask, just off"
    def off(*_args)
      if options[:help]
        invoke :help, ["off"]
      else
        require_relative "commands/off"
        Devbin::Commands::Off.new(:all, options).execute
      end
    end

    desc "navigate APP_NAME", "Quick navigate to the main folder of the app"
    def navigate(app_name)
      if options[:help]
        invoke :help, ["off"]
      else
        require_relative "commands/navigate"
        Devbin::Commands::Navigate.new(:all, options).execute
      end
    end
    map %w(cd) => :navigate

    require_relative "commands/rails"
    register Devbin::Commands::Rails, "rails", "rails [SUBCOMMAND]", "Control the Rails application"

    require_relative "commands/configure"
    register Devbin::Commands::Configure, "configure", "configure [SUBCOMMAND]", "Configure the workspace"
  end
end
