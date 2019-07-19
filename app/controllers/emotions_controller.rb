class EmotionsController < ApplicationController
  before_action :admin_user

  def create
    @emotion = Emotion.new(emotion_params)
    if @emotion.save
      flash[:notice] = '登録しました。'
      redirect_to emotions_path
    else
      @emotions = Emotion.page(params[:page]).per(10).reverse_order
      flash[:notice] = '同名以外の１０文字以内で登録可能です。'
      render :index
    end
  end

  def index
    @emotion = Emotion.new
    @emotions = Emotion.page(params[:page]).per(10).reverse_order
  end

  def update
    @emotion = Emotion.find(params[:id])
    if @emotion.update(emotion_params)
      flash[:notice] = '更新しました。'
      redirect_to emotions_path
    else
      @emotions = Emotion.page(params[:page]).per(10).reverse_order
      flash[:notice] = '同名以外の１０文字以内で登録可能です。'
      render :index
    end
  end

  def destroy
    emotion = Emotion.find(params[:id])
    emotion.destroy
    flash[:notice] = '削除しました。'
    redirect_to emotions_path
  end


  private

  def emotion_params
    params.require(:emotion).permit(:emotion_name)
  end
end