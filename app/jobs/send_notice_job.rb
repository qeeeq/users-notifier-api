class SendNoticeJob < ApplicationJob
  queue_as :default

  def perform(user, title, description)
    user.send_notification_to_user(title, description)
  end
end
