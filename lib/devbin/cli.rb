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

    desc "version", "devbin version"
    def version
      require_relative "version"
      puts "v#{Devbin::VERSION}"
    end
    map %w(--version -v) => :version

    desc "bash APP_NAME", "Attach to bash for the given app"
    method_option :help, aliases: "-h", type: :boolean,
      desc: "Display usage information"
    def bash(app_name)
      if options[:help]
        invoke :help, ["bash"]
      else
        require_relative "commands/bash"
        Devbin::Commands::Bash.new(app_name, options).execute
      end
    end
    map %w(sh) => :bash

    require_relative "commands/rails"
    register Devbin::Commands::Rails, "rails", "rails [SUBCOMMAND]", "Control the Rails application"
  end
end
