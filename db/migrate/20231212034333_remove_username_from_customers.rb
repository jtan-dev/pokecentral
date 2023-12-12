class RemoveUsernameFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :username, :string
  end
end
