RSpec.describe "`devbin rails restart` command", type: :cli do
  it "executes `devbin rails help restart` command successfully" do
    output = `devbin rails help restart`
    expected_output = <<-OUT
Usage:
  devbin restart APP_NAME

Options:
  -h, [--help], [--no-help]  # Display usage information

Restart docker-sync stack and the application
    OUT

    expect(output).to eq(expected_output)
  end
end
