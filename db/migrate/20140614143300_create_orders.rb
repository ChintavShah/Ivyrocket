class CreateOrders < ActiveRecord::Migration
  def change
    create_table(:orders) do |t|
      t.string :express_token
      t.string :payer_id

      t.timestamps
    end

  end
end
