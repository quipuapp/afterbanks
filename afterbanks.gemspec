lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'afterbanks/version'

Gem::Specification.new do |s|
  s.add_dependency 'addressable', '~> 2.3'
  s.add_dependency 'http', '~> 2.0'
  s.add_dependency 'http_parser.rb', '~> 0.6.0'
  s.add_development_dependency 'bundler', '~> 1.0'

  s.name     = 'afterbanks'
  s.version  = Afterbanks::Version
  s.authors  = ['Oriol Francès']
  s.email    = ['oriol@getquipu.com']
  s.summary  = 'Ruby client for the Afterbanks API'
  s.homepage = 'https://getquipu.com'
  s.license  = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
