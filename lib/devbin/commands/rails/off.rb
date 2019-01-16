# frozen_string_literal: true

require_relative "../../command"

module Devbin
  module Commands
    class Rails
      class Off < Devbin::Command
        def initialize(options)
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          require_relative "stop"
          Devbin::Commands::Rails::Stop.new(@app_name, {all: true, sync: true}).execute
          output.puts pastel.green.on_bright_black.bold("Remember to `git push' before go home")
        end
      end
    end
  end
end
