class AddUserToReminders < ActiveRecord::Migration[7.2]
  def change
    add_reference :reminders, :user, null: false, foreign_key: true
  end
end
