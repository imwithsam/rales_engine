class ChangeUnitPriceInItems < ActiveRecord::Migration
  def change
    change_column :items, :unit_price, :decimal, precision: 8, scale: 2
  end
end
