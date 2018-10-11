class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
		create_table :profiles, :id => false, :primary_key => :email do |t|
			t.text :email, null: false
			t.text :first_name
			t.text :middle_name
			t.text :last_name
			t.text :display_name, null: false
			t.text :phone_number
			t.text :gender
			t.text :language, array: true, null: false
			t.text :country, default: 'Canada'
			t.text :facebook
			t.text :google
			t.text :wechat
			t.text :twitter
			t.text :avatar_url, null: false
			t.text :interest, array: true
      t.timestamps
    end
  end
end


