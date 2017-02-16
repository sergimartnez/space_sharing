class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
    	t.references 		:user, index: true
    	t.string				"type_of_space"
      t.timestamps
    end
  end
end
