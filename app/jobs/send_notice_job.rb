class SendNoticeJob < ApplicationJob
  queue_as :default

  def perform(note, title, description)
    note.send_notification(title, description)
  end
end
