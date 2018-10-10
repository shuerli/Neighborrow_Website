class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
			t.integer :request_id
			t.integer :item_id
			t.text :lender
			t.integer :address
			t.text :status, default: 'pending'
			t.text :rejected_reason
			t.timestamp :time_start
			t.timestamp :time_end
			t.timestamp :time_pickup
			t.boolean :received, default: 'false'
			t.boolean :returned, default: 'false'
      t.timestamps
    end
  end
end
