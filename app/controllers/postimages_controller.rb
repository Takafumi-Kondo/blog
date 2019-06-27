class PostimagesController < ApplicationController
# あとで複数画像投稿可予定

  # before_action :authenticate_user!

  # def create
  #   post = Post.find(params[:post_id])
  #   postimage = Postimage.new(postimage_params)
  #   postimage.post_id = post.id
  #   postimage.save
  #   redirect_to post_path(post.id)
  # end


  # private

  # def postimage_params
  #   params.require(:postimage).permit(:post_id, :image)
  # end
end
