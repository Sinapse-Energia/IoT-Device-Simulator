class DevicesController < ApplicationController
  def index
    fetch_data
  end

  def new
    @device = Device.new
    @devices = Device.all
    @templates = Template.all.map{|t| [t.name, t.id] }
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      @device.create_mqtt_broker
      redirect_to :devices
    else
      redirect_back
    end
  end

  def update
    @device = Device.find(params[:id])
    file = params[:device][:api_json].read
    data = JSON.parse(file)
    @device.update(api_json: data, template_id: params[:device][:template_id])
    redirect_to root_path
  end

  # MQTT operations
  def connect
    update_mqtt_details
    client = mqtt_client
    client.connect
    @device.mqtt_broker.update(connected: true)
    redirect_to root_path
  end

  private

  def device_params
    params.require(:device).permit(:name, :interfaces_peripherals, :template_id, :user_id)
  end

  def fetch_data
    @devices = Device.all.map.map{|d| [d.name, d.id] }
    @device = Device.find(params[:device_id] || @devices.first.last)
    @templates = Template.all.map{|t| [t.name, t.id] }
  end

  def mqtt_client
    MQTT::Client.new(host: params[:host],
       port: params[:port],
       username: params[:user],
       password: params[:password]
    )
  end

  def update_mqtt_details
    @device = Device.find(params[:id])
    @device.mqtt_broker.update(host: params[:host],
       port: params[:port],
       username: params[:user],
       password: params[:password])
  end
end
