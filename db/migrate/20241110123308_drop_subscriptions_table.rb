class DropSubscriptionsTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :subscriptions
  end

  def down
    create_table :subscriptions do |t|
      # Recreate the columns that were in the `subscriptions` table
      t.references :user, foreign_key: true
      t.string :subscription_code
      t.timestamps
    end
  end
end
