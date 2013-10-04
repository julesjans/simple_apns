A simple gem for sending push notifications directly through Apple's Push Notification Service.

Best uses are in testing, or in production for small services (internal apps etc), it is not liable to scale well. 


###Pre-requisites

This gem requires Ruby >=1.9.3 & Daemons.


###Preparation

1. You must first obtain an APNS certificate and then create a .pem file: [developer.apple.com](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ProvisioningDevelopment.html)

2. You must have a vaild token to push to an iOS device.


###Installation

This gem is not distributed built. Either clone & build, or use bundler:

```ruby	

	gem 'simple_apns', :git => 'https://github.com/julesjans/simple_apns.git'
```


###Configuration

Once the gem is installed:

```ruby
	require 'simple_apns'
	
	SimpleAPNS::Settings.config do |config|
  
	  # Necessary configuration:
	  config.cert  	= "/My/Certificates/certificate.pem"
	  config.pid   	= "/tmp"
  
	  # Optional configuration:
	  config.mode  	= :production
	  config.port  	= 20000
	  config.params = [:id]
  
	end
```


You need to configure:

1. Where the .pem certificate is.

2. Where to locate the .pid file for the server.

Optionally you can configure:

1. The mode, :sandbox (default) or :production

2. The port that the local APNS Server will use, default is: 20000

3. Additional params: the standard message includes a single text string, here you can include other params, e.g. an identifier.


###Usage

```ruby
	token   = "a1a1a1a1a..."
	text    = "Hello World!"

	SimpleAPNS::send_notification(token, text)
```
	
Sending a notification will start the APNS server (if it is not already started). It will remain running, waiting for more notifications to send, until it is stopped:

```ruby
	SimpleAPNS::stop_server
```

The server can be manually started, or restarted, without sending a message:

```ruby
	SimpleAPNS::start_server
	
	SimpleAPNS::restart_server
```

Addtionally configured parameters are included in a hash:

```ruby
	SimpleAPNS::send_notification(token, text, {:id => 'my_identifier'})
```

	
###Limitations

1. The notification payload is limited to 256 bytes.


###Todo

1. Test APNS Service feedback:

```ruby
	SimpleAPNS::check_feedback
```

2. Implement testing library.



