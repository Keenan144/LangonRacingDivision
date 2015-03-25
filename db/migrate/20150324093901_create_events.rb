class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text    :content
      t.string  :title
      t.string  :date
      t.string  :location
      t.integer :user_id

      t.timestamps
    end
  end
end