class AddUnitPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :unit_price, :decimal
  end

  def self.down
    remove_column :products, :unit_price
  end
end
