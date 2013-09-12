module SimpleAPNS

  module Settings
    
    extend self
    
    def config(&block)
      instance_eval &block
      @set = true
    end
    
    def cert
      raise SimpleAPNS::MissingCertificate unless @cert
      @cert
    end
  
    def pid
      raise SimpleAPNS::MissingPid unless @pid
      @pid
    end
    
    def mode
      @mode || :sandbox
    end
    
    def port
      @port || 20000
    end

    def apns_address
      self.mode == :production ? 'gateway.push.apple.com' : 'gateway.sandbox.push.apple.com'
    end
    
    def feedback_address
      self.mode == :production ? 'feedback.push.apple.com' : 'feedback.sandbox.push.apple.com'
    end
    
    def options
      @options || []
    end
    
    def check
      raise SimpleAPNS::MissingCertificate unless @cert
      raise SimpleAPNS::MissingPid unless @pid
    end
    
    protected
    
    def set?
      @set
    end
    
    def set=(set)
      @set = set
    end
    
    def cert=(cert)
      raise RuntimeError if set?
      @cert = cert
    end
    
    def pid=(pid)
      raise RuntimeError if set?
      @pid = pid
    end
    
    def mode=(mode)
      raise RuntimeError if set?
      @mode = mode
    end
    
    def port=(port)
      raise RuntimeError if set?
      @port = port
    end
    
    def options=(options)
      raise RuntimeError if set?
      @options = options
    end

  end
  
end