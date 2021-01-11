# frozen_string_literal: true
require "devbin/commands/rails/restart"

RSpec.describe Devbin::Commands::Rails::Restart do
  it "executes `rails restart` command successfully" do
    output = StringIO.new
    app_name = nil
    options = {}
    command = Devbin::Commands::Rails::Restart.new(app_name, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
