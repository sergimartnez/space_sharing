class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references  :user, index: true
      t.references  :garage, index: true
      t.references  :search, index: true
      t.string      :address_first
      t.string      :address_second
      t.string      :street
      t.string      :country
      t.timestamps
    end
  end
end
