class AddColumnsToReminders < ActiveRecord::Migration[7.2]
  def change
    add_column :reminders, :name, :string
    add_column :reminders, :description, :string
  end
end
