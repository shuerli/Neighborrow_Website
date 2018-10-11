class CreateFeedbackToBorrowers < ActiveRecord::Migration[5.2]
  def change
    create_table :feedback_to_borrowers, :id => false, :primary_key => :ftb_id do |t|
			t.integer :ftb_id
			t.integer :request_id
			t.integer :rate
			t.text :tag, array: true
			t.integer :credit
			t.text :comment
      t.timestamps
    end
  end
end

