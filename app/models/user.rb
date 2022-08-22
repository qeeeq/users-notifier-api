class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  has_many :devices, class_name: 'UserDevice'
  has_many :notifications

  def send_notification_to_user(title, description)
    payload = {payload: { title: title , description: description } }
    tokens = devices.where(device_type: 'android').pluck(:token).compact
    
    UserDevice.send_notification(tokens, payload, 'android')
  end
end
