class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
  end
end
