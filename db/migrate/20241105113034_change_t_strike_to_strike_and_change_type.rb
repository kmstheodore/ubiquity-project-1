class ChangeTStrikeToStrikeAndChangeType < ActiveRecord::Migration[7.2]
  def change
    # Rename the column first
    rename_column :reminders, :t_strike, :strike

    # Change the data type from time to datetime with explicit cast
    change_column :reminders, :strike, 'timestamp USING (to_timestamp(strike::text, \'HH24:MI:SS\'))'
  end
end
