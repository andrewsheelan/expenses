class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.references :sender, null: false, foreign_key: {to_table: :users}, index: true
      t.references :recipient, null: false, foreign_key: {to_table: :users}, index: true

      t.timestamps
    end
    add_foreign_key :conversations, :users, column: :sender_id
    add_foreign_key :conversations, :users, column: :recipient_id

  end
end
