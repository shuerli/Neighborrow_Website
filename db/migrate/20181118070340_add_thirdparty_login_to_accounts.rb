class AddThirdpartyLoginToAccounts < ActiveRecord::Migration[5.2]
  def change
      add_column :accounts, :provider, :string
      add_column :accounts, :uid, :string
      add_column :accounts, :name, :string
      add_column :accounts, :oauth_token, :string
      add_column :accounts, :oauth_expires_at, :datetime
  end
end
