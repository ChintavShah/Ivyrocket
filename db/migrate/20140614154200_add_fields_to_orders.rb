class AddFieldsToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :ip_address, :string
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :payer, :string
    add_column :orders, :name, :string
    add_column :orders, :street1, :string
    add_column :orders, :street2, :string
    add_column :orders, :city_name, :string
    add_column :orders, :state_or_province, :string
    add_column :orders, :country, :string
    add_column :orders, :country_name, :string
    add_column :orders, :postal_code, :string
    add_column :orders, :order_total, :string
    add_column :orders, :order_total_currency_id, :string
    add_column :orders, :mentor_id, :integer
    add_index :orders, :mentor_id
    add_column :orders, :user_id, :integer
    add_index :orders, :user_id
  end
end