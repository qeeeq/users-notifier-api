class Notification < ApplicationRecord
  validates :notify_at, presence: true

  belongs_to :user
  belongs_to :user_device
end
