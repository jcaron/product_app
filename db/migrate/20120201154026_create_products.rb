class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :name, :unique => true
  end

  def self.down
    drop_table :products
  end
end
