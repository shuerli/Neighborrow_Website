class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses, :id => false, :primary_key => :address_id do |t|
			t.integer :address_id
			t.text :email, null: false
			t.text :address_line1, null: false
			t.text :address_line2
			t.text :city, null: false
			t.text :province, null: false
			t.text :country, null: false
			t.text :postal_code
      t.timestamps
    end
  end
end
