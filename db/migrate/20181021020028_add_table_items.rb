class AddTableItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :customer_id
      t.text :preferences
      t.timestamps null: false
    end
    add_foreign_key :items, :customers, dependent: :delete
  end
end
