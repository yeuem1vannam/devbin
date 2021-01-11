# frozen_string_literal: true
require "devbin/commands/rails/stop"

RSpec.describe Devbin::Commands::Rails::Stop do
  it "executes `rails stop` command successfully" do
    output = StringIO.new
    app_name = nil
    options = {}
    command = Devbin::Commands::Rails::Stop.new(app_name, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
