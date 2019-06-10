class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
    	t.integer :user_id
    	t.integer :genre_id
    	t.integer :emotion_id
    	t.string :title
    	t.text :body
      t.integer :impressions_count, default: 0

      t.timestamps
    end
  end
end
