class CreateFeedbackToBorrowers < ActiveRecord::Migration[5.2]
  def change
    create_table :feedback_to_borrowers do |t|
			t.integer :request_id, null: false
			t.integer :rate, null: false
			t.text :tag, array: true
			t.integer :credit, null: false
			t.text :comment
      t.timestamps
    end
  end
end

