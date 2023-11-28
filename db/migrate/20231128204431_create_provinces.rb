class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :code
      t.string :full_name
      t.float :tax_percentage

      t.timestamps
    end
  end
end
