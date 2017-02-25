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
      t.timestamps
    end
  end
end
