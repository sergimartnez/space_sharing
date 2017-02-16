class CreateAppOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :app_operations do |t|

      t.timestamps
    end
  end
end
