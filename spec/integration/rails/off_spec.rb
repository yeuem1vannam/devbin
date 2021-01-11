# frozen_string_literal: true
RSpec.describe "`devbin rails off` command", type: :cli do
  it "executes `devbin rails help off` command successfully" do
    output = %x(devbin rails help off)
    expected_output = <<-OUT
Usage:
  devbin off

Options:
  -h, [--help], [--no-help]  # Display usage information

Close all active containers and go home
    OUT

    expect(output).to eq(expected_output)
  end
end
