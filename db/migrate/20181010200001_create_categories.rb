class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
			t.text :department, null: false
			t.text :name, null: false, unique: true
      t.timestamps
    end
  end
end

