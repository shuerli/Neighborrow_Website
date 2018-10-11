class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories, :id => false, :primary_key => :category_id do |t|
			t.integer :category_id
			t.text :department
			t.text :name
      t.timestamps
    end
  end
end

