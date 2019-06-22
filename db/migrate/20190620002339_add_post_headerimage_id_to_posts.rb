class AddPostHeaderimageIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_headerimage_id, :string
  end
end
