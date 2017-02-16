class CreateDaySearchItems < ActiveRecord::Migration[5.0]
  def change
    create_table :day_search_items do |t|
    	t.references		:search, index: true
    	t.string				:week_day
    	t.integer 			:start_hour
    	t.integer 			:start_minute
    	t.integer 			:end_hour
    	t.integer 			:end_minute
      t.text          :array_of_desired_times
      t.timestamps
    end
  end
end