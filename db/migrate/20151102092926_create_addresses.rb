class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :telephone
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :county
      t.string :post_code
      t.string :country
      t.text :delivery_notes
      t.string :company_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
