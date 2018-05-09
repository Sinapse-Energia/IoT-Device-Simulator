module Devices
  class ConnectService
    attr :device_id,
         :config

    def initialize(attributes)
      @config = attributes
    end

    # This method will return client
    def connect
      MQTT::Client
        .connect(config)
    end
  end
end
