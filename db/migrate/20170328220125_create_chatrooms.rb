class CreateChatrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chatrooms do |t|
      t.references  :shared_rental, foreign_key: true
      t.string      :topic
      t.timestamps
    end
  end
end
