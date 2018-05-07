class DevicesChannel < ApplicationCable::Channel
  attr :client

  def subscribed
    stream_from "device_#{params['device_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def get_message(data)
    DeviceCommunicationSyncJob.perform_now(data)
    Resque.enqueue_at(1.second.from_now, DeviceCommunicationSyncJob, :device_id => data['device_id'], data: data)
    # Resque.enqueue_at(1.seconds.from_now, DeviceCommunicationSyncJob, :device_id => data['device_id'], data: data)
    # DeviceMessageDisplayWorker.perform_in(1.second, data)

    # client.get('TEST_VERVE.IOT') do|topic, msg|
    #   ActionCable.server.broadcast "device_#{params['device_id']}_channel",
    #                                topic: topic,
    #                                msg: msg,
    #                                hours: Time.now.strftime('%d-%m-%Y %H:%M:%S')
    # end
  end

  # private

  # def connect_mqtt_client(data)
  #   config = data.dig('config')
  #   MQTT::Client.connect(config)
  # end

end
