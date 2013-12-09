Gem::Specification.new do |s|
  s.name             = 'rutracker_api'
  s.version          = '0.0.1'
  s.summary          = "API for rutracker.org"
  s.description      = "Provide simple api for rutracker.org"

  s.authors          = ['Dmytro Bignyak']
  s.email            = 'bignyak@bigmir.net'
  s.homepage         = 'https://github.com/deril/rutracker_api'
  s.license          = 'MIT'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.rdoc']
  s.require_paths    = ['lib']

  s.add_dependency 'mechanize', ['>=2.7.2']

  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'rake', ['>= 0']
  s.add_development_dependency 'rspec', ['>= 0']
  s.add_development_dependency 'rdoc', ['>= 0']
end
