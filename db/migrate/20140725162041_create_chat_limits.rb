class CreateChatLimits < ActiveRecord::Migration
  def change
    create_table :chat_limits do |t|
      t.string :email
      t.integer :chattimes
      t.datetime :chatstamp

      t.timestamps
    end
    add_index :chat_limits, :email, unique: true
  end
end
