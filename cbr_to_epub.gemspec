# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cbr_to_epub/version'

Gem::Specification.new do |spec|
  spec.name          = 'cbr_to_epub'
  spec.version       = CbrToEpub::VERSION
  spec.authors       = ['Rafal Cymerys']
  spec.email         = ['rafal@latenightcoding.co']

  spec.summary       = %q{A simple gem for converting cbr files to epub}
  spec.homepage      = 'https://rubygems.org/gems/cbr_to_epub'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = ''
  spec.executables   = ["cbr"]
  spec.require_paths = ['lib']

  spec.add_dependency 'image_optim', '~> 0.26.1'
  spec.add_dependency 'parallel', '~> 1.12'
  spec.add_dependency 'listen', '~> 3.1.5'
  spec.add_dependency 'image_optim_pack', '~> 0.5.0.20180419'
  spec.add_dependency 'ruby-progressbar', '~> 1.9'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
end
