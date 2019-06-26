class GenresController < ApplicationController
  before_action :admin_user

  def create
  	@genre = Genre.new(genre_params)
  	if @genre.save
  		redirect_to genres_path
  	else
  		render :index
  	end
  end

  def index
  	@genre = Genre.new
  	@genres = Genre.page(params[:page]).per(10).reverse_order
  end

  def update
  	genre = Genre.find(params[:id])
  	if genre.update(genre_params)
  		redirect_to genres_path
  	else
  		@genres = Genre.page(params[:page]).per(10).reverse_order
  		render :index
  	end
  end

  def destroy
  	genre = Genre.find(params[:id])
  	genre.destroy
  	redirect_to genres_path
  end


  private

  def genre_params
  	params.require(:genre).permit(:genre_name)
  end
end
