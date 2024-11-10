class CreateFcmTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :fcm_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
