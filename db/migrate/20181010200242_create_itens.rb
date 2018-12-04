class CreateItens < ActiveRecord::Migration[5.2]
  def change
    create_table :itens do |t|
			t.text :owner, null: false
			t.text :status, null: false, default:'registered'
			t.text :category_id, null: false
			t.integer :address, null: false
			t.text :condition, null: false
			t.text :rate_level, default:0
			#t.text :address_option, array: true, null: false
			t.timestamp :time_start, null: false
			t.timestamp :time_end, null: false
            #t.timestamp :time_pickup, array: true, null: false
			t.text :name, null: false
			t.integer :deposit, default: 0
			t.text :photo_url
			t.text :description
			t.text :brand
			t.text :feature, array: true
			t.text :amazon_id
			t.text :walmart_id
			t.text :isbn
      t.timestamps
    end
  end
end
