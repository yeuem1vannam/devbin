# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Restart < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        stop()
        start()

        output.puts pastel.yellow.bold("OK")
      end

      private

      def stop
        require_relative "stop"
        stop_options = { sync: @options[:sync] }
        Devbin::Commands::Stop.new(@app_name, stop_options).execute
      end

      def start
        require_relative "start"
        start_options = { sync: @options[:sync] }
        Devbin::Commands::Start.new(@app_name, start_options).execute
      end
    end
  end
end
