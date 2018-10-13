class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
			t.text :email, null: false
			t.text :address_line1, null: false
			t.text :address_line2
			t.text :city, null: false
			t.text :province, null: false
			t.text :country, null: false
			t.text :postal_code, null:false
      t.timestamps
    end
  end
end
