module SimpleAPNS
  
  class Feedback
  
    @@sock, @@ssl = nil, nil
    
    def self.get_connection
    
      if @@ssl == nil || @@sock == nil
      
        ctx = OpenSSL::SSL::SSLContext.new
        ctx.key = OpenSSL::PKey::RSA.new(File.read(SimpleAPNS::Settings.cert), '')
        ctx.cert = OpenSSL::X509::Certificate.new(File.read(SimpleAPNS::Settings.cert))

        @@sock = TCPSocket.new(SimpleAPNS::Settings.feedback_address, 2196) 
        @@ssl = OpenSSL::SSL::SSLSocket.new(@@sock, ctx)
        # @@ssl.sync = true
        @@ssl.connect
  
      end
      
    end
    
    def self.ssl
      return @@ssl
    end
    
    def self.socket
      return @@sock
    end
    
    def self.disconnect
      @@ssl.close
      @@sock.close
      
      @@ssl = nil
      @@sock = nil 
    end

  end
  
end
