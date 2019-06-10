class CreatePostimages < ActiveRecord::Migration[5.2]
  def change
    create_table :postimages do |t|
    	t.integer :post_id
    	t.string :image_id

		t.timestamps
    end
  end
end
