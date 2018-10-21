class AddTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :capacity
      t.timestamps null: false
    end
  end
end
