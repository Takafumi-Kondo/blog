class GenresController < ApplicationController
  before_action :admin_user

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = '登録しました。'
      redirect_to genres_path
    else
      @genres = Genre.page(params[:page]).per(10).reverse_order
      flash[:notice] = '同名以外の１２文字以内で登録可能です。'
      render :index
    end
  end

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(10).reverse_order
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = '更新しました。'
      redirect_to genres_path
    else
      @genres = Genre.page(params[:page]).per(10).reverse_order
      flash[:notice] = '同名以外の１２文字以内で登録可能です。'
      render :index
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    flash[:notice] = '削除しました。'
    redirect_to genres_path
  end


  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end
end