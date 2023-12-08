class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.references :province, null: true, foreign_key: true

      t.timestamps
    end
  end
end
