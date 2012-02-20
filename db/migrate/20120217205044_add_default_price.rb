class AddDefaultPrice < ActiveRecord::Migration
  def self.up
    change_column :products, :unit_price, :decimal, :precision => 10, 
      :scale => 2, :default => 0
    change_column :line_items, :unit_price, :decimal, :precision => 10, 
      :scale => 2, :default => 0
  end

  def self.down
    change_column :products, :unit_price, :decimal
    change_column :line_items, :unit_price, :decimal, :precision => 10, 
      :scale => 2
  end
end
