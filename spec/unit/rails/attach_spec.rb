require "devbin/commands/rails/attach"

RSpec.describe Devbin::Commands::Rails::Attach do
  it "executes `rails attach` command successfully" do
    output = StringIO.new
    app_name = nil
    options = {}
    command = Devbin::Commands::Rails::Attach.new(app_name, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
