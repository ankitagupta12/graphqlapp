class AddComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :article_id
      t.timestamps null: false
    end
    add_foreign_key :comments, :articles, dependent: :delete
  end
end
