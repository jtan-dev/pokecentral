class RemoveEmailFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :email, :string
    remove_column :customers, :password, :string
  end
end
