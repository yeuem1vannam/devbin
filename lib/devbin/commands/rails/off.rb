# frozen_string_literal: true

require_relative '../../command'

module Devbin
  module Commands
    class Rails
      class Off < Devbin::Command
        def initialize(options)
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          require_relative 'stop'
          Devbin::Commands::Rails::Stop.new(@app_name, {all: true}).execute
          output.puts "OK"
        end
      end
    end
  end
end
