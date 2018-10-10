class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
			t.text :email
			t.text :role
			t.text :password
			t.text :salt
			t.text :status
      t.timestamps
		end
  end
end
