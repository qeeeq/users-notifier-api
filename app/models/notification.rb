class Notification < ApplicationRecord
  validates :notify_at, presence: true, comparison: { greater_than: Time.current }
  belongs_to :user
  belongs_to :user_device

  def send!
    payload = {payload: { title: title , description: description } }
    messenger = PushMessenger::Gcm.new
    begin
      messenger.deliver("#{user_device.device_type}_app", user_device.token, payload)
    rescue Exception => error
      Rails.logger.debug error
    end
  end
end
