class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :start_date, null:false
      t.date :end_date, null:false
      t.string :remark
      t.timestamps null: false
    end
  end
end
