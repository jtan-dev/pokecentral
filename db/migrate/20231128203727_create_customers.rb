class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :username
      t.string :password
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
