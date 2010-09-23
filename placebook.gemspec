$LOAD_PATH.unshift 'lib'
require "placebook/version"

Gem::Specification.new do |s|
  s.name              = "placebook"
  s.version           = Placebook::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A gem for accessing the Facebook Places API."
  s.homepage          = "http://github.com/golubeff/placebook"
  s.email             = "pavel@golubeff.ru"
  s.authors           = [ "Paul Golubev" ]
  s.has_rdoc          = false

  s.files             = %w( README.rdoc Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("man/**/*")
  s.files            += Dir.glob("test/**/*")

  s.add_dependency('oauth2')
  s.add_dependency('hashie')
end
