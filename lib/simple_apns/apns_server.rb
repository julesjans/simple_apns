# Start local server

local_server = TCPServer.new('localhost', SimpleAPNS::Settings.port)

begin

  SimpleAPNS::Connection.get_connection

  loop do
      Thread.start(local_server.accept) do |request|
        message = request.gets
        notification = SimpleAPNS::Notification.new(message)
      
        SimpleAPNS::Connection.send_notification(notification)
    
        # TODO: do we receive a warning from Apple if the connection is going to go down.
        # FIXME: issue a raise//retry here if the connection has been dropped by Apple
    
      end
      if IO.select([SimpleAPNS::Connection.ssl], nil, nil, 5)        
        read_buffer = SimpleAPNS::Connection.ssl.read(6)
        SimpleAPNS::Error.process_error_response(read_buffer)
        raise
      end
  end

rescue
  SimpleAPNS::Connection.disconnect 
  retry
end 


