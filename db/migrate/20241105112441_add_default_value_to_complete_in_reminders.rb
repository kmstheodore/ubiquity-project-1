class AddDefaultValueToCompleteInReminders < ActiveRecord::Migration[7.2]
  def change
    change_column_default :reminders, :complete, false
  end
end
