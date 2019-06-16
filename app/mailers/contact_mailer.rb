class ContactMailer < ApplicationMailer
		default from: '"運営局" <adtanaka.taro1111@gmail.com>'

	def contact_mail(contact)
		@contact = contact
		mail(to:      @contact.user.email,
				 subject: "お問い合わせありがとうございます。")
	end
end
#binding.pry
