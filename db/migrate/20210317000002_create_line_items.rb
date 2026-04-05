class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer :cart_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, default: 1, null: false
      t.timestamps
    end
    add_index :line_items, [:cart_id, :product_id], unique: true
  end
end
