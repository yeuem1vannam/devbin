# frozen_string_literal: true

require "thor"

module Devbin
  module Commands
    class Configure < Thor
      Error = Class.new(StandardError)

      namespace :configure

      class_option :help, aliases: "-h", type: :boolean,
        desc: "Display usage information"

      desc "add APP_NAME", "Add application to the current workspace"
      def add(app_name)
        if options[:help]
          invoke :help, ["add"]
        else
          require_relative "configure/add"
          Devbin::Commands::Configure::Add.new(app_name, options).execute
        end
      end
    end
  end
end
