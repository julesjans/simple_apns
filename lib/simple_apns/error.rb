module SimpleAPNS
  
  class Error
    
    def self.process_error_response(error)
      puts "hello there has been an error: #{error.inspect}"
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