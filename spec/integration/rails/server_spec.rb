RSpec.describe "`devbin rails server` command", type: :cli do
  it "executes `devbin rails help server` command successfully" do
    output = `devbin rails help server`
    expected_output = <<-OUT
Usage:
  devbin server ATTACH FALSE

Options:
  -h, [--help], [--no-help]  # Display usage information

Control the Rails application
    OUT

    expect(output).to eq(expected_output)
  end
end
