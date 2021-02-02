class RemoveIdFromFriendship < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE friendships DROP CONSTRAINT friendships_pkey"
    execute "ALTER TABLE friendships ADD PRIMARY KEY (sender_id,receiver_id);"
    remove_column :friendships, :status
    remove_column :friendships, :id
  end
end
