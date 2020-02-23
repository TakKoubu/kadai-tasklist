class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :like, foreign_key: { to_table: :tasks }

      t.timestamps
      
      t.index [:user_id, :like_id], unique: true
    end
  end
end
