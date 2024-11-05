class AddTStrikeToReminders < ActiveRecord::Migration[7.2]
  def change
    add_column :reminders, :t_strike, :time
  end
end
