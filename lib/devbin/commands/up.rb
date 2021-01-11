# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Up < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(output: $stdout)
        require_relative "start"
        start_options = { sync: @options[:sync] }
        Devbin::Commands::Start.new(@app_name, start_options).execute
        unless @options[:detach]
          require_relative "attach"
          attach_options = {}
          Devbin::Commands::Attach.new(@app_name, attach_options).execute
        end
        output.puts pastel.yellow.bold("OK")
      end
    end
  end
end
