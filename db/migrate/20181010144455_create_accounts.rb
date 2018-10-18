class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
			t.text :email, null: false, unique: true
			t.text :role, null: false
			t.text :password, null: false
			t.text :salt, null: false
			t.text :status, null: false
      t.timestamps
		end
  end
end
