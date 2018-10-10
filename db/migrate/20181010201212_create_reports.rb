class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
			t.integer :report_id
			t.text :type
			t.text :subject
			t.text :content
			t.text :status
			t.text :handler
			t.integer :request_id
      t.timestamps
    end
  end
end

