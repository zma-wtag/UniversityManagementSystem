class AddEmailPhonePasswordAddressToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :users, :phone, :string
    add_column :users, :password_digest, :string
    add_column :users, :address, :string
  end
end
