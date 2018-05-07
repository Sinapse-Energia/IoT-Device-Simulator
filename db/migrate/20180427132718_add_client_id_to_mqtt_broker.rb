class AddClientIdToMqttBroker < ActiveRecord::Migration[5.1]
  def change
    add_column :mqtt_brokers, :client_id, :string
  end
end
