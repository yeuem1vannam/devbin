# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Off < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(output: $stdout)
        if will_stop?
          stop
          output.puts pastel.green.on_bright_black.bold("Remember to `git push' before go home")
        else
          output.puts pastel.red.on_bright_black.bold("Keep working...")
        end
      end

      private

      def will_stop?
        return true if @options[:yes]
        !prompt.no?(pastel.yellow.bold("Turn off the workspace?"))
      end

      def stop
        require_relative "stop"
        stop_options = { all: true, sync: true }
        Devbin::Commands::Stop.new(:all, stop_options).execute
      end
    end
  end
end
