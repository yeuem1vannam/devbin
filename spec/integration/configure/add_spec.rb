# frozen_string_literal: true
RSpec.describe "`devbin configure add` command", type: :cli do
  it "executes `devbin configure help add` command successfully" do
    output = %x(devbin configure help add)
    expected_output = <<-OUT
Usage:
  devbin configure add APP_NAME

Options:
  -h, [--help], [--no-help]  # Display usage information

Add application to the current workspace
    OUT

    expect(output).to eq(expected_output)
  end

  it "creates configure file" do
    %x(devbin configure add new-app)
    expect(File.exist?("#{Dir.home}/.config/devbin/config.yml")).to be_truthy
  end
end
