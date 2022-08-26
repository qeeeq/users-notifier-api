class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :user_device, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :notify_at

      t.timestamps
    end
  end
end
