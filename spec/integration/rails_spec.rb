# frozen_string_literal: true
RSpec.describe "`devbin rails` command", type: :cli do
  it "executes `devbin help rails` command successfully" do
    output = %x(devbin help rails)
    expected_output = <<-OUT
Commands:
    OUT

    expect(output).to eq(expected_output)
  end
end
