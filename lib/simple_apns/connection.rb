
# Server only

module SimpleAPNS
  
  class Connection
    
    @@sock, @@ssl = nil, nil
    
    def self.get_connection
  
      if @@ssl == nil || @@sock == nil
        
        ctx         = OpenSSL::SSL::SSLContext.new
        ctx.key     = OpenSSL::PKey::RSA.new(File.read(SimpleAPNS::Settings.cert), '')
        ctx.cert    = OpenSSL::X509::Certificate.new(File.read(SimpleAPNS::Settings.cert))

        @@sock      = TCPSocket.new(SimpleAPNS::Settings.apns_address, 2195) 
        @@ssl       = OpenSSL::SSL::SSLSocket.new(@@sock, ctx)
        @@ssl.sync  = true
        @@ssl.connect
      end
      
    end
    
    def self.ssl
      return @@ssl
    end
    
    def self.disconnect
      @@ssl.close
      @@sock.close
      @@ssl  = nil
      @@sock = nil  
    end
    
    def self.send_notification(notification)
      @@ssl.write(notification.binary_message)
    end
  
  end
end






