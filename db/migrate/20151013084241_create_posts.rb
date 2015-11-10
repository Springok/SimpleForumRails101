class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :context
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
