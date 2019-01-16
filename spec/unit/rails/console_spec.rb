require "devbin/commands/rails/console"

RSpec.describe Devbin::Commands::Rails::Console do
  it "executes `rails console` command successfully" do
    output = StringIO.new
    app_name = nil
    options = {}
    command = Devbin::Commands::Rails::Console.new(app_name, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
