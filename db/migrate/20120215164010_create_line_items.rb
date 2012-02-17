class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :product_id
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
