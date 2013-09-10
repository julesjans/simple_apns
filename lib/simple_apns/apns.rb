module SimpleAPNS
  
  def self.send_notification(token, title, text)
    begin
      self.start_server
      socket = TCPSocket.new('localhost', SimpleAPNS::Settings.port)
      notification = "#{token}\0#{text}\0#{title}\0nil"
      socket.write(notification)
      socket.close
    rescue 
      raise StandardError
    end
  end
  

  def self.start_server
    if !File.exists?("#{SimpleAPNS::Settings.pid}/apns_server.rb.pid")
      `ruby #{File.dirname(__FILE__)}/apns_server_daemon.rb start -- #{SimpleAPNS::Settings.cert} #{SimpleAPNS::Settings.pid} #{SimpleAPNS::Settings.mode} #{SimpleAPNS::Settings.port}`
      sleep 5
    end
  end
  
  
  def self.stop_server
    if File.exists?("#{SimpleAPNS::Settings.pid}/apns_server.rb.pid")
      `ruby #{File.dirname(__FILE__)}/apns_server_daemon.rb stop -- #{SimpleAPNS::Settings.cert} #{SimpleAPNS::Settings.pid} #{SimpleAPNS::Settings.mode} #{SimpleAPNS::Settings.port}`
    end
  end
  
  def self.restart_server
    if File.exists?("#{SimpleAPNS::Settings.pid}/apns_server.rb.pid")
      `ruby #{File.dirname(__FILE__)}/apns_server_daemon.rb restart -- #{SimpleAPNS::Settings.cert} #{SimpleAPNS::Settings.pid} #{SimpleAPNS::Settings.mode} #{SimpleAPNS::Settings.port}`
    else
      self.start_server
    end
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