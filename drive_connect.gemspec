Gem::Specification.new do |spec|
  spec.name          = "drive_connect"
  spec.version       = '0.0.7'
  spec.authors       = ["Tyler Johnston"]
  spec.email         = ["tylerjohnst@gmail.com"]
  spec.summary       = "Shared logic between the web and mobile"
  spec.description   = "Shared logic between the web and mobile"
  spec.homepage      = ""
  spec.license       = "NONE"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
end
