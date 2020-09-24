class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: { to_table: :users } # ActiveRecord add_reference

      t.timestamps
    end

    add_index :friendships, %i[user_id friend_id], unique: true
  end
end
