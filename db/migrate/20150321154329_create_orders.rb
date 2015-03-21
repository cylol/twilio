class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :phone
      t.string :sid
      t.references :hotel, index: true
      t.boolean :status

      t.timestamps null: false
    end
    add_foreign_key :orders, :hotels
  end
end
