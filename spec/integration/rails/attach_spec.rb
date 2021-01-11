# frozen_string_literal: true
RSpec.describe "`devbin rails attach` command", type: :cli do
  it "executes `devbin rails help attach` command successfully" do
    output = %x(devbin rails help attach)
    expected_output = <<-OUT
Usage:
  devbin attach APP_NAME

Options:
  -h, [--help], [--no-help]  # Display usage information

Attach to the rails server
    OUT

    expect(output).to eq(expected_output)
  end
end
