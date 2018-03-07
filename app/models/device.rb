class Device < ApplicationRecord
  belongs_to :user
  belongs_to :template

  has_one :mqtt_broker
end
