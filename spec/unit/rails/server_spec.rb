require "devbin/commands/rails/server"

RSpec.describe Devbin::Commands::Rails::Server do
  it "executes `rails server` command successfully" do
    output = StringIO.new
    app_name = nil
    options = {}
    command = Devbin::Commands::Rails::Server.new(app_name, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
