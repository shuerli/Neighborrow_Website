class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats, :id => false, :primary_key => :chat_id do |t|
			t.integer :chat_id, null: false
			t.integer :request_id
			t.integer :report_id
			t.timestamp :time, null: false
			t.text :sender, null: false
			t.text :receiver, null: false
			t.text :content, null: false
      t.timestamps
    end
  end
end

