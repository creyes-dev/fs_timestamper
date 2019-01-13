
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fs_timestamper/version"

Gem::Specification.new do |spec|
  spec.name          = "fs_timestamper"
  spec.version       = FsTimestamper::VERSION
  spec.authors       = ["creyes-dev"]
  spec.email         = ["reyescristiane@gmail.com"]

  spec.summary       = "A gem for changing filesystem timestamps"
  spec.description   = "Provides a unified and simplified interface for changing filesystem timestamps using different methods supporting mac, windows and linux filesystems"
  spec.homepage      = "https://github.com/creyes-dev/fs_filestamper"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
