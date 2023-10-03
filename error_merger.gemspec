# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'error_merger/version'

Gem::Specification.new do |spec|
  spec.name          = 'error_merger'
  spec.version       = ErrorMerger::VERSION
  spec.authors       = ['thomas morgan']
  spec.email         = ['tm@iprog.com']
  spec.description   = %q{Enhances the Error class on ActiveModel-compliant models with merge() and full_sentences() methods.}
  spec.summary       = %q{Enhances the Error class on ActiveModel-compliant models}
  spec.homepage      = 'https://github.com/zarqman/error_merger'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency 'activemodel', '>= 6.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
