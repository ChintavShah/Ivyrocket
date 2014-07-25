class AddChatLimitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chattimes, :integer
    add_column :users, :chatstamp, :datetime
  end
end
