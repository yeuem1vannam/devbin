# frozen_string_literal: true
require 'devbin/commands/configure/add'

RSpec.describe Devbin::Commands::Configure::Add do
  it "executes `configure add` command successfully" do
    output = StringIO.new
    app_name = nil
    options = {}
    command = Devbin::Commands::Configure::Add.new(app_name, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
