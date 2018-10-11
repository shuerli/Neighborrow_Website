class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories, :id => false, :primary_key => :category_id do |t|
			t.integer :category_id, null: false
			t.text :department, null: false
			t.text :name, null: false
      t.timestamps
    end
  end
end

