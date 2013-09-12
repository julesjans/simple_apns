Gem::Specification.new do |s|
  
  s.name          = 'simple_apns'
  s.summary       = 'A super simple gem for communicating with the Apple Push Notification service.'
  s.description   = 'To come'
  s.version       = "0.0.1"
  s.author        = 'Jules Jans'
  s.email         = 'julesjans@me.com'
  s.platform      = Gem::Platform::RUBY
  s.files         = Dir['lib/**/**']
  s.test_files    = Dir["test/test*.rb"]
  s.has_rdoc      = false
  
  # s.required_ruby_version = '>=2.0.0'
  
  s.add_dependency "daemons"

end