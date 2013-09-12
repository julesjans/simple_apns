module SimpleAPNS
  
  class Error
    
    def self.process_error_response(error)
      puts "hello there has been an error: #{error.inspect}"
    end
    
  end
  
  class ServerFailure < StandardError
    def message
      "Could not communicate with the server"
    end
  end
  
  class SocketFailure < StandardError
    def message
      "Could not communicate with the socket"
    end
  end
  
  class NotificationSize < StandardError
    def message
      "The notification payload must be under 256 bytes"
    end
  end
  
  class MissingCertificate < StandardError
    def message
      "You must congfigure a certificate for this server"
    end
  end
  
  class MissingPid < StandardError
    def message
      "You must congfigure a pidfile location for this server"
    end
  end
  
end