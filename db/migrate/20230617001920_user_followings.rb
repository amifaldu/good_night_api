class UserFollowings < ActiveRecord::Migration[7.0]
  def change
  	create_table :user_followings, comment: 'Table for storing user followings' do |t|
      t.references :follower_user, foreign_key: { to_table: 'users' },  comment: 'User who is following'
      t.references :following_user, foreign_key: { to_table: 'users' }, comment: 'User being followed'
      t.timestamps
    end
    add_index :user_followings, [:follower_user_id, :following_user_id], unique: true, name: 'index_followings_on_user_id_and_following_user_id', comment: 'Index for unique user followings'
  end
end