class RemoveClientIdFromMqttBrokers < ActiveRecord::Migration[5.1]
  def change
    remove_column :mqtt_brokers, :client_id, :string
  end
end
