class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references  :user, index: true
      t.references  :space, index: true
      t.references  :search, index: true
      t.string      :address_1
      t.string      :address_2
      t.string      :country
      t.string      :postal_code
      t.string      :province
      t.float       :longitude
      t.float       :latitude
      t.timestamps
    end
  end
end
