class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :delivery_date
      t.references :address, index: true, foreign_key: true
      t.boolean :payment_success
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
