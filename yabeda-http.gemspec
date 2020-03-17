# frozen_string_literal: true

require_relative 'lib/yabeda/http/version'

Gem::Specification.new do |spec|
  spec.name          = 'yabeda-http'
  spec.version       = Yabeda::Http::VERSION
  spec.authors       = ['Dmitry Salahutdinov']
  spec.email         = ['dsalahutdinov@gmail.com']

  spec.summary       = 'Monitoring of external services http/https calls'
  spec.description   = 'Extends Yabeda metrics to collect external calls'
  spec.homepage      = 'https://github.com/yabeda-rb/yabeda-http'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/yabeda-rb/yabeda-http'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sniffer'
  spec.add_runtime_dependency 'yabeda'
end
