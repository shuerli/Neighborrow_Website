class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts, :id => false, :primary_key => :email do |t|
			t.text :email, null: false
			t.text :role, null: false
			t.text :password, null: false
			t.text :salt, null: false
			t.text :status, null: false
      t.timestamps
		end
  end
end
