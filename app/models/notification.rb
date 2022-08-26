class Notification < ApplicationRecord
  validates :notify_at, presence: true

  belongs_to :user
  belongs_to :user_device

  def send_notification(title, description)
    payload = {payload: { title: title , description: description } }
    device = UserDevice.find(user_device_id)
    messenger = PushMessenger::Gcm.new

    begin
      messenger.deliver(device.device_type, device.token, payload)
    rescue Exception => error
      Rails.logger.debug error
    end
  end
end
