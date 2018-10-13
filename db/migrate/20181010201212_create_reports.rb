class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
			t.text :report_type, null: false
			t.text :subject, null: false
			t.text :content, null: false
			t.text :status, null: false
			t.text :handler
			t.timestamp :time_submitted, null: false
			t.timestamp :time_closed
			t.integer :request_id
      t.timestamps
		end
		
		
  end
end

