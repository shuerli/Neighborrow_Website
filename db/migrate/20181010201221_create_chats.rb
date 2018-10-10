class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
			t.integer :chat_id
			t.integer :request_id
			t.integer :report_id
			t.timestamp :time
			t.text :sender
			t.text :receiver
			t.text :content
      t.timestamps
    end
  end
end

