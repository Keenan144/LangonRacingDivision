class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text    :content
      t.string  :title
      t.string  :pagetype
      t.string :photo
      t.integer :user_id

      t.timestamps
    end
  end
end