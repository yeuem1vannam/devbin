require "devbin/commands/rails/off"

RSpec.describe Devbin::Commands::Rails::Off do
  it "executes `rails off` command successfully" do
    output = StringIO.new
    options = {}
    command = Devbin::Commands::Rails::Off.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
