class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
    	t.references 	:user, index: true
    	t.references	:space, index: true
    	t.string			:space_type
      t.boolean     :active
      t.string      :title
      t.text        :description
    	t.text				:array_of_desired_times
      t.string      :address_1
      t.string      :address_2
      t.string      :country
      t.string      :postal_code
      t.string      :province
      t.float       :longitude
      t.float       :latitude
      t.string      :city
      t.timestamps
    end
  end
end
