require 'mqtt'
class DevicesController < ApplicationController
  def index
    fetch_data
  end

  def new
    @device = params[:id].present? ? Device.find_by(id: params[:id]) : Device.new
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
    if params[:device][:api_json].present?
      # For device management when upload json
      file = params[:device][:api_json].read
      data = JSON.parse(file)
      @device.update(api_json: data, template_id: params[:device][:template_id])
    else
      # Normal device updation
      @device.update(device_params)
    end
    redirect_to root_path
  end

  # MQTT device connect operations
  def connect
    client = connect_mqtt_client

    if client.connected?
      update_mqtt_details
      @device.mqtt_broker.update(connected: true)
      redirect_to '/'
    end
  end

  # MQTT device disconnect operations
  def disconnect
    client = connect_mqtt_client

    if client.connected?
      client.disconnect()

      @device = Device.find(params[:id])
      @device.mqtt_broker.update(connected: false)
      redirect_to root_url
    end
  end

  def get_device
    @device = Device.find_by(id: params[:id])
    @templates = Template.pluck(:name, :id)
    render partial: 'device_tabs', locals: {device: @device, templates: @templates}
  end

  private

  def device_params
    params.require(:device).permit(:name, :interfaces_peripherals, :template_id, :user_id)
  end

  def fetch_data
    @devices = Device.all.map{|d| [d.name, d.id] }
    @device = Device.find_by(id: @devices.first.last)
    @templates = Template.all.map{|t| [t.name, t.id] }
  end

  def connect_mqtt_client
    connection_params = {
      host: params[:mqtt_broker][:host],
      port: params[:mqtt_broker][:port],
      client_id: MQTT::Client.generate_client_id
    }

    username = params[:mqtt_broker][:username]
    password = params[:mqtt_broker][:password]

    connection_params.merge!(
      username: username,
      password: password
    ) if username != '' && password != ''

    MQTT::Client.connect(connection_params)
  end

  def update_mqtt_details
    @device = Device.find(params[:id])
    @device.mqtt_broker.update(host: params[:mqtt_broker][:host],
       port: params[:mqtt_broker][:port],
       username: params[:mqtt_broker][:user],
       password: params[:mqtt_broker][:password])
  end
end
