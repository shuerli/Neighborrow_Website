class CreatePays < ActiveRecord::Migration[5.2]
  def change
    create_table :pays do |t|
      t.text :email, null: false
      t.integer :add_credit
      t.integer :withdraw_credit
      t.integer :credit
      t.timestamps
    end
  end
end
