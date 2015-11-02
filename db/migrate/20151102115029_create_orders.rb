class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :delivery_date
      t.integer :address_id
      t.boolean :payment_success
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
