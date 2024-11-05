class AddRepeatCounterAndActiveToReminders < ActiveRecord::Migration[7.2]
  def change
    add_column :reminders, :repeat, :boolean
    add_column :reminders, :counter, :integer, default: 0
    add_column :reminders, :active, :boolean
  end
end
