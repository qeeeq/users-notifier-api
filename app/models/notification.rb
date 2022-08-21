class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :user_device
end
