lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rutracker_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'rutracker_api'
  spec.version       = RutrackerApi::VERSION
  spec.authors       = ['Dmytro Bihniak']
  spec.email         = '570757+deril@users.noreply.github.com'

  spec.summary       = 'Search API for rutracker.org'
  spec.description   = 'Provide simple search api for rutracker.org'
  spec.homepage      = 'https://github.com/deril/rutracker_api'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/deril/rutracker_api'
    spec.metadata['changelog_uri'] = 'https://github.com/deril/rutracker_api/blob/master/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mechanize', '~> 2.7'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
