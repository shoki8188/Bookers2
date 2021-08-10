class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :followed_id, null: false
      t.integer :follower_id, null: false
      t.timestamps

      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
