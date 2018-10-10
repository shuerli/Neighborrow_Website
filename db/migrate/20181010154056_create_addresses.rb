class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
			t.integer :address_id
			t.text :email
			t.text :address_line1
			t.text :address_line2
			t.text :city
			t.text :province
			t.text :country
			t.text :postal_code
      t.timestamps
    end
  end
end
