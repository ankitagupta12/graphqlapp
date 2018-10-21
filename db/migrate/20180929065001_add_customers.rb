class AddCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :table_id
      t.timestamps null: false
    end
    add_foreign_key :customers, :tables, dependent: :delete
  end
end
