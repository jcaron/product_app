class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :sub_category_id
      t.integer :product_id

      t.timestamps
    end
    add_index :relationships, :sub_category_id
    add_index :relationships, :product_id
  end

  def self.down
    drop_table :relationships
  end
end
