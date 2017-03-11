class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
    	t.references 		:user, index: true
      t.string        :title       
    	t.string				:type_of_space
      t.text          :description
      t.integer       :space_dimensions
      t.integer       :space_capacity
      t.boolean       :active
      t.string        :address_1
      t.string        :address_2
      t.string        :country
      t.string        :postal_code
      t.string        :province
      t.float         :longitude
      t.float         :latitude
      t.string        :city
      t.boolean       :full_availability
      t.text          :availability
      t.timestamps
    end
  end
end
