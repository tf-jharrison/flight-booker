class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.references :flight, foreign_key: { to_table: :flights }  
      t.timestamps
    end
  end
end
