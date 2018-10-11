class CreateFeedbackToLenders < ActiveRecord::Migration[5.2]
  def change
    create_table :feedback_to_lenders, :id => false, :primary_key => :ftl_id do |t|
			t.integer :ftl_id
			t.integer :request_id
			t.integer :rate
			t.text :tag, array:true
			t.integer :credit
			t.text :comment 
      t.timestamps
    end
  end
end
