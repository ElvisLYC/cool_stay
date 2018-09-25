class AddMoreDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :property_type, :string
    add_column :listings, :room_number, :integer
    add_column :listings, :bed_number, :integer
    add_column :listings, :guest_number, :integer

    add_column :listings, :country, :string
    add_column :listings, :state, :string
    add_column :listings, :city, :string
    add_column :listings, :zipcode, :integer
    add_column :listings, :address, :string

  end
end
