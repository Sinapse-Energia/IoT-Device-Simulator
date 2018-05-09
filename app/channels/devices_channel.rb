class DevicesChannel < ApplicationCable::Channel
  attr :client

  def subscribed
    stream_from "device_#{params['device_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def start_messeging(params)
    @device =
      Devices::ConnectService
        .new(params.dig('config').reject{|key, val| key.eql?('topic')})

    @communication =
        Devices::CommunicationService
        .new(
          params.dig('device_id'),
          @device.connect,
          params.dig('config', 'topic')
        )

    # Starting Messages
    @communication.start_messaging
  end
end
