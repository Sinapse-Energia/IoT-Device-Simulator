class DeviceMessageDisplayWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 5, :dead => false, queue: :device_message_display

  def perform(data)
    @client = @client || connect_mqtt_client(data)
    @client.get('TEST_VERVE.IOT') do|topic, msg|
      ActionCable.server.broadcast "device_#{data['device_id']}_channel",
                                   topic: topic,
                                   msg: msg,
                                   hours: Time.now.strftime('%d-%m-%Y %H:%M:%S')
    end

  end

  private

  def connect_mqtt_client(data)
    config = data.dig('config')
    MQTT::Client.connect(config)
  end
end
