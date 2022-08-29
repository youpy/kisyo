# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kisyo/version'

Gem::Specification.new do |spec|
  spec.name = 'kisyo'
  spec.version = Kisyo::VERSION
  spec.authors = ['youpy']
  spec.email = ['youpy@buycheapviagraonlinenow.com']
  spec.summary =
    'A ruby tool for getting weather information from www.data.jma.go.jp'
  spec.homepage = ''
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'webmock'
end
