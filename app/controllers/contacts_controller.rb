class ContactsController < ApplicationController
	#before_action ログインユーザー のみ
	#before_action adminか

	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		@contact.user_id = current_user.id
		if @contact.save
			redirect_to '/posts'
		else
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
			redirect_to '/contacts'
		end
	end

	def destroy
		contact = Contact.find(params[:id])
		contact.destroy
		redirect_to '/contacts'
	end


	private

	def contact_params
		params.require(:contact).permit(:user_id, :title, :contact_content, :responce)
	end
end
