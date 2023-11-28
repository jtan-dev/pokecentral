class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :type
      t.integer :stock

      t.timestamps
    end
  end
end
