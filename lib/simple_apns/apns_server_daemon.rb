require_relative "../simple_apns.rb"

SimpleAPNS::Settings.config do |config|
  config.cert = ARGV[2]
  config.pid  = ARGV[3]
  config.mode = ARGV[4].to_sym
  config.port = ARGV[5].to_i
end

SimpleAPNS::Settings.check

Daemons.run("#{File.dirname(__FILE__)}/apns_server.rb", :dir_mode => :normal, :dir => SimpleAPNS::Settings.pid)