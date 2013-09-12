module SimpleAPNS
  
  def self.send_notification(token, text, opts={})
    
    self.start_server
  
    notification = "#{token}\0#{text}"
      
    SimpleAPNS::Settings.params.each {|param| notification << "\0#{opts[param]}"}
     
    notification_byte_size(token, text, opts)

    begin
      socket = TCPSocket.new('localhost', SimpleAPNS::Settings.port)
      socket.write(notification)
      socket.close
    rescue 
      raise SimpleAPNS::SocketFailure
    end
  end
  
  def self.notification_byte_size(token, text, opts={})
    test_payload = {"aps" => {"alert" => text, "badge" => 0, "sound" => 'default'}}
    opts.each {|k,v| test_payload[k] = v}
    test_payload = test_payload.to_json() 
    bytes        = [1, 0, 0, 0, 32, token, test_payload.length, test_payload].pack("cNNccH*na*").length
    
    raise SimpleAPNS::NotificationSize if bytes > 256
  end

  def self.start_server
    begin
      if !File.exists?("#{SimpleAPNS::Settings.pid}/apns_server.rb.pid")
        `ruby #{File.dirname(__FILE__)}/apns_server_daemon.rb start -- #{server_settings}`
        sleep 5
      end
    rescue
      raise SimpleAPNS::ServerFailure
    end
  end
  
  def self.stop_server
    begin
      if File.exists?("#{SimpleAPNS::Settings.pid}/apns_server.rb.pid")
        `ruby #{File.dirname(__FILE__)}/apns_server_daemon.rb stop -- #{server_settings}`
      end
    rescue
      raise SimpleAPNS::ServerFailure
    end
  end
  
  def self.restart_server
    begin
      if File.exists?("#{SimpleAPNS::Settings.pid}/apns_server.rb.pid")
        `ruby #{File.dirname(__FILE__)}/apns_server_daemon.rb restart -- #{server_settings}`
      else
        self.start_server
      end
    rescue
      raise SimpleAPNS::ServerFailure
    end
  end
  
  def self.server_settings
    "#{SimpleAPNS::Settings.cert} #{SimpleAPNS::Settings.pid} #{SimpleAPNS::Settings.mode} #{SimpleAPNS::Settings.port} #{SimpleAPNS::Settings.params.collect {|p| p.to_s} .join(',')}" 
  end
  
  
  
  
  
  
  
  def self.check_feedback
    
    # TODO: return a dictionary of objects with the time and the token
    
    # APNS::Feedback.get_connection
    # 
    # messages = []  
    # 
    # while line = APNS::Feedback.ssl.read(38)
    #   f = line.unpack('N1n1H64')
    #   messages << {:time => Time.at(f[0]), :token => f[2]}
    # end
    # 
    # APNS::Feedback.disconnect
    #  
    # for message in messages
    #   iphone = Iphone.find(:first, :conditions => {:token => message[:token]})
    #   iphone.destroy if iphone.created_at.to_time < message[:time] 
    # end
    
  end
  
end