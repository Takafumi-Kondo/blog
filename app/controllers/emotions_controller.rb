class EmotionsController < ApplicationController
  before_action :admin_user

  def create
  	@emotion = Emotion.new(emotion_params)
  	if @emotion.save
  		redirect_to emotions_path
  	else
  		render :index
  	end
  end

  def index
  	@emotion = Emotion.new
  	@emotions = Emotion.page(params[:page]).per(10).reverse_order
  end

  def update
  	emotion = Emotion.find(params[:id])
  	if emotion.update(emotion_params)
  		redirect_to emotions_path
  	else
  		@emotion = Emotion.page(params[:page]).per(10).reverse_order
  		render :index
  	end
  end

  def destroy
  	emotion = Emotion.find(params[:id])
  	emotion.destroy
  	redirect_to emotions_path
  end


  private

  def emotion_params
  	params.require(:emotion).permit(:emotion_name)
  end
end
#binding.pry