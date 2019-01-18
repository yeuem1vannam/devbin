# frozen_string_literal: true

require_relative "../command"

module Devbin
  module Commands
    class Navigate < Devbin::Command
      def initialize(app_name, options)
        @app_name = app_name
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.puts pastel.yellow(
          "Trying to navigate to application #{@app_name}",
          "\n",
          "Will be implemeted after `configure'"
        )
      end
    end
  end
end
