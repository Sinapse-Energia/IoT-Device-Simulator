class CreateMqttBrokers < ActiveRecord::Migration[5.1]
  def change
    create_table :mqtt_brokers do |t|
      t.string :host
      t.string :port
      t.string :username
      t.string :password
      t.references :device, foreign_key: true
      t.boolean :connected

      t.timestamps
    end
  end
end
