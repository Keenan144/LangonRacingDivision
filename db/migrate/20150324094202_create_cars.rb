class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.text    :info
      t.string  :make
      t.string  :model
      t.string  :engine
      t.string  :drive
      t.string  :color
      t.integer :horsepower
      t.integer :top_speed
      t.integer :noto_sixty
      t.integer :number
      t.integer :user_id

      t.timestamps
    end
  end
end