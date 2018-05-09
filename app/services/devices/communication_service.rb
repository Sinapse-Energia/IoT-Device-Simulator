module Devices
  class CommunicationService
    attr :client,
         :device_id,
         :job,
         :device,
         :communication_topic

    def initialize(device_id, client, topic)
      @device_id = device_id
      @client = client
      @device = Device.find(device_id)
      @communication_topic = topic
    end

    def start_messaging
      @job =
          Thread.new do
            @client.get("#{communication_topic}") do|topic, msg|
              ActionCable.server.broadcast "device_#{device_id}_channel",
                                           topic: topic,
                                           msg: msg,
                                           hours: Time.now.strftime('%d-%m-%Y %H:%M:%S')

              job_id = Thread.current.object_id
              unless job_id.eql?(device.job_id.to_i)
                device.update_attributes(job_id: job_id)
              end
            end
          end
    end

    def shutdown
      Thread.list.each do|thread|
        if thread.object_id.eql?(device.job_id.to_i)
          device.update_attributes(job_id: nil)
          thread.kill
        end
      end
    end
  end
end