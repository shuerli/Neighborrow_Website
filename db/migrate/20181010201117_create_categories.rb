class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
			t.integer :category_id
			t.text :department
			t.text :name
      t.timestamps
    end
  end
end

