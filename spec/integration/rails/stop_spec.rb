# frozen_string_literal: true
RSpec.describe "`devbin rails stop` command", type: :cli do
  it "executes `devbin rails help stop` command successfully" do
    output = %x(devbin rails help stop)
    expected_output = <<-OUT
Usage:
  devbin stop APP_NAME

Options:
  -h, [--help], [--no-help]  # Display usage information

Stop the rails application
    OUT

    expect(output).to eq(expected_output)
  end
end
