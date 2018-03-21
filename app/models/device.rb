class Device < ApplicationRecord
  belongs_to :user
  belongs_to :template

  has_one :mqtt_broker

  def interfaces
    self.interfaces_peripherals.try(:split, "\r\n")
  end
end
