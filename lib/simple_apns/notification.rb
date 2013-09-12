# Server only

module SimpleAPNS
  
  class Notification
    
    def initialize(message)
      
      token = message.split(/\0/)[0]
      alert = message.split(/\0/)[1]
      
      @payload = {"aps" => {"alert" => alert, "badge" => 0, "sound" => 'default'}}
      
      SimpleAPNS::Settings.options.each.with_index(2) do |option, index| 
        @payload[option.to_s] = message.split(/\0/)[index]
      end
      
      @json = @payload.to_json() 
      @token = token
      
    end
    
    def binary_message
      # Need to make this the enhanced form of the message with id & expiry?
      return [1, 0, 0, 0, 32, @token, @json.length, @json].pack("cNNccH*na*")
    end

  end
  
end