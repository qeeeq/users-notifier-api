module PushMessenger
  class Gcm
    def deliver(app, tokens, payload, expiry=1.day.to_i)
      tokens = *tokens
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by_name(app)
      n.registration_ids = tokens
      n.expiry = expiry
      n.data = payload
      n.priority = 'high'
      n.save!
    end
  end
end
