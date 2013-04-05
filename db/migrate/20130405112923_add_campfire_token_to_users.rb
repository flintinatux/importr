class AddCampfireTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :campfire_token, :string
  end
end
