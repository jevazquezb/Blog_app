class AddAuthorRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :author_id, :bigint, null: false
    add_foreign_key :posts, :users, column: :author_id
    add_index :posts, :author_id
  end
end
