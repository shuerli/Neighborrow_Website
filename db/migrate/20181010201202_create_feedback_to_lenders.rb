class CreateFeedbackToLenders < ActiveRecord::Migration[5.2]
  def change
    create_table :feedback_to_lenders, :id => false, :primary_key => :ftl_id do |t|
			t.integer :ftl_id, null: false
			t.integer :request_id, null: false
			t.integer :rate, null: false
			t.text :tag, array:true, null: false
			t.integer :credit, null: false
			t.text :comment 
      t.timestamps
    end
  end
end