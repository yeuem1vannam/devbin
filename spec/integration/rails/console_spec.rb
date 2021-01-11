# frozen_string_literal: true
RSpec.describe "`devbin rails console` command", type: :cli do
  it "executes `devbin rails help console` command successfully" do
    output = %x(devbin rails help console)
    expected_output = <<-OUT
Usage:
  devbin console APP_NAME

Options:
  -h, [--help], [--no-help]  # Display usage information

Start the rails console
    OUT

    expect(output).to eq(expected_output)
  end
end
