# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "devbin/version"

Gem::Specification.new do |spec|
  spec.name          = "devbin"
  spec.license       = "MIT"
  spec.version       = Devbin::VERSION
  spec.authors       = ["Phuong 'J' Le H."]
  spec.email         = ["yeuem1vannam@users.noreply.github.com"]

  spec.summary       = 'Seamlessly control your containerized workspace'
  spec.description   = <<~DESC
  Power up the containerized workspace with docker + docker-sync.
  Run command anywhere in your workspace
  DESC
  spec.homepage = "https://github.com/yeuem1vannam/devbin"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/yeuem1vannam/devbin"
    # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    %x(git ls-files -z).split("\x0").reject do |f|
      f.match(%r{^(test|spec|features|samples|docs)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tty-command"
  spec.add_dependency "tty-cursor"
  spec.add_dependency "tty-editor"
  spec.add_dependency "tty-file"
  spec.add_dependency "tty-pager"
  spec.add_dependency "tty-prompt"
  spec.add_dependency "tty-screen"
  spec.add_dependency "tty-which"
  spec.add_dependency "pastel"
  spec.add_dependency "thor", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
