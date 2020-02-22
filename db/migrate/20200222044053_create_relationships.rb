class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :favorite, foreign_key: { to_table: :users }

      t.timestamps
      
      t.index [:user_id, :favorite_id], unique: true
    end
  end
end
