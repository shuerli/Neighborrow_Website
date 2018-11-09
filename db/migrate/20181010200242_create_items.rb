class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
			t.text :owner, null: false
			t.text :status, null: false, default:'registered'
			t.text :condition, null: false
			t.integer :category, null: false
			t.text :rate_level
			#t.text :address_option, array: true, null: false
			t.timestamp :time_start, null: false
			t.timestamp :time_end, null: false
			#t.timestamp :time_pickup, array: true, null: false
			t.text :name, null: false
			t.text :photo_url
			t.text :description, null: false
			t.text :brand
			t.text :feature, array: true
			t.text :amazon_id
			t.text :walmart_id
			t.text :isbn
      t.timestamps
    end
  end
end
