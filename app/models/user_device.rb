class UserDevice < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :delete_all
end
