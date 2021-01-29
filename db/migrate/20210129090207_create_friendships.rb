class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.string :create
      t.string :update
      t.string :delete

      t.timestamps
    end
  end
end
