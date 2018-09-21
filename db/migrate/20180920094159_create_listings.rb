class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :property_title
      t.string :location, null: false
      t.string :price, null: false
      t.string :description, null: false
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
