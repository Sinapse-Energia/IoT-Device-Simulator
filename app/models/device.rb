class Device < ApplicationRecord
  belongs_to :user
  belongs_to :template

  has_one :mqtt_broker
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "120x120#" },
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename",
                    :default_url => "/assets/missing_device.png"

  validates_attachment_content_type :image, content_type: ["image/png", "image/jpg", "image/jpeg"]

  def interfaces
    self.interfaces_peripherals.try(:split, "\r\n")
  end

  def topic
    api_json&.dig('baseTopic')&.split('.')&.push('DEBUG')&.join('/')
  end

  def client_id
    if (api_json && api_json.dig('baseTopic')).present?
      api_json&.dig('baseTopic')&.split('.')[0]
    else
      nil
    end
  end
end
