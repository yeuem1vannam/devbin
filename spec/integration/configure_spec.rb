RSpec.describe "`devbin configure` command", type: :cli do
  it "executes `devbin help configure` command successfully" do
    output = `devbin help configure`
    expected_output = <<-OUT
Commands:
  devbin configure add APP_NAME    # Add application to the current workspace
  devbin configure help [COMMAND]  # Describe subcommands or one specific subcommand

Options:
  -h, [--help], [--no-help]  # Display usage information

    OUT

    expect(output).to eq(expected_output)
  end
end
