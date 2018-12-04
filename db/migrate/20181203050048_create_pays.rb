class CreatePays < ActiveRecord::Migration[5.2]
  def change
    create_table :pays do |t|
      t.text :email, null: false
      t.integer :add_credit
      t.integer :withdraw_credit
      t.integer :credit
      t.text :payid
      t.boolean :add, default:false
      t.text :paypal_email
      t.timestamps
    end
  end
end
