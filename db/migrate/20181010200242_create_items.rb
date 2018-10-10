class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
			t.integer :item_id
			t.text :owner
			t.text :condition
			t.text :category
			t.text :rate_level
			t.text :address_option, array: true
			t.timestamp :time_start
			t.timestamp :time_end
			t.timestamp :time_pickup, array: true
			t.text :name
			t.text :description
			t.text :brand
			t.integer :year
			t.text :feature, array: true
			t.text :amazon_id
			t.text :walmart_id
      t.timestamps
    end
  end
end
