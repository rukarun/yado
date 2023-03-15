class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer :people
      t.integer :total_day
      t.integer :total_price

      t.timestamps
    end
  end
end
