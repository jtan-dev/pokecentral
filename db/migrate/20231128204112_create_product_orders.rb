class CreateProductOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :product_orders do |t|
      t.integer :quantity
      t.float :subtotal
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
