class CreateSharedRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_rentals do |t|
      t.string        :status
      t.timestamps
    end
  end
end
