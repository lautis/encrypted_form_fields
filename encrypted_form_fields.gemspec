# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'encrypted_form_fields/version'

Gem::Specification.new do |spec|
  spec.name          = "encrypted_form_fields"
  spec.version       = EncryptedFormFields::VERSION
  spec.authors       = ["Ville Lautanala"]
  spec.email         = ["lautis@gmail.com"]
  spec.summary       = %q{Encrypted form fields for Rails}
  spec.description   = %q{Encrypted form fields for Rails}
  spec.homepage      = "https://github.com/lautis/encrypted_form_fields"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 1.9.3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "actionpack", ">= 4.0"
  spec.add_runtime_dependency "activesupport", ">= 4.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "appraisal", "~> 2.0"
  spec.add_development_dependency "nokogiri", "~> 1.6"
end
