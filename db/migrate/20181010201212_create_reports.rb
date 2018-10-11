class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports, :id => false, :primary_key => :report_id do |t|
			t.integer :report_id, null: false
			t.text :type, null: false
			t.text :subject, null: false
			t.text :content, null: false
			t.text :status, null: false
			t.text :handler
			t.timestamp :time_submitted, null: false
			t.timestamp :time_closed, null: false
			t.integer :request_id
      t.timestamps
    end
  end
end

