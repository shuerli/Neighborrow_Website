class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
			t.integer :item_id, null: false
			t.text :borrower, null: false
			t.integer :address
			t.text :status, default: 'pending'
			t.text :rejected_reason
			t.timestamp :time_start, null: false
			t.timestamp :time_end, null: false
			t.timestamp :time_pickup, null: false
			t.boolean :received, default: 'false', null: false
			t.boolean :returned, default: 'false', null: false
      t.timestamps
    end
  end
end
