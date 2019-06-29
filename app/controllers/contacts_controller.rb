class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, :only => [:show, :index, :update, :destroy]

  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new(contact_params)
    contact.user_id = current_user.id
    if contact.save
      flash[:notice] = 'お問い合わせありがとうございます。承りました。'
      redirect_to root_path
    else
      flash[:notice] = '件名 内容を入力してください。'
      render :new
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @contacts = Contact.page(params[:page]).per(10).reverse_order
  end
# 問い合わせ返信
  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      ContactMailer.contact_mail(@contact).deliver_now
      binding.pry
      flash[:notice] = "返信しました。"
      redirect_to contacts_path
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    flash[:notice] = '削除しました。'
    redirect_to contacts_path
  end


  private

  def contact_params
    params.require(:contact).permit(:user_id, :title, :contact_content, :responce)
  end
end