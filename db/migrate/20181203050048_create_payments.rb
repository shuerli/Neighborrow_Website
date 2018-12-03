class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.text :email, null: false
      t.text :add_credit
      t.text :withdraw_credit
      t.text :credit
      t.timestamps
    end
  end
end
