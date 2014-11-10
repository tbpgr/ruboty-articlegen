# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/gen/version'

# rubocop:disable LineLength
Gem::Specification.new do |spec|
  spec.name          = 'ruboty-articlegen'
  spec.version       = Ruboty::Gen::VERSION
  spec.authors       = ['tbpgr']
  spec.email         = ['tbpgr@tbpgr.jp']
  spec.summary       = 'ruboty-articlegen generate ruboty Article Markdown template.'
  spec.description   = 'ruboty-articlegen generate ruboty Article Markdown template.'
  spec.homepage      = 'https://github.com/tbpgr/ruboty-articlegen'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 0.18.1'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
# rubocop:enable LineLength
