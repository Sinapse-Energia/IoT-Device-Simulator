class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :terms_of_service, acceptance: true
  validates :email, uniqueness: true
  validates :email, :first_name, :last_name, presence: true

  has_many :devices

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "120x120#" },
  :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  :url => "/system/:attachment/:id/:style/:filename",
  :default_url => "/assets/:style/missing.svg"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
