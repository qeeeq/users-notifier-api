class SendNoticeJob < ApplicationJob
  queue_as :default

  def perform(note_id)
    note = Notification.find(note_id)
    note.send!
  end
end
