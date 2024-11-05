class AddCompleteToReminders < ActiveRecord::Migration[7.2]
  def change
    add_column :reminders, :complete, :boolean
  end
end
