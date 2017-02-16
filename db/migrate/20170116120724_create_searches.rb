class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
    	t.references 	:user, index: true
    	t.references	:space, index: true
    	t.string			:space_type
    	t.text				:array_of_desired_times
      t.timestamps
    end
  end
end
