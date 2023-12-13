class RemoveTaxPercentageFromProvinces < ActiveRecord::Migration[7.0]
  def change
    remove_column :provinces, :tax_percentage, :float
  end
end
