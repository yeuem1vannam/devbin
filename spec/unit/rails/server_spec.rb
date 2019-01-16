require 'devbin/commands/rails/server'

RSpec.describe Devbin::Commands::Rails::Server do
  it "executes `rails server` command successfully" do
    output = StringIO.new
    attach = nil
    false = nil
    options = {}
    command = Devbin::Commands::Rails::Server.new(attach, false, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
