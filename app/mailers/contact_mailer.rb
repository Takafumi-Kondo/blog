class ContactMailer < ApplicationMailer
		default from: 'adtanaka.taro1111@gmail.com'

	def contact_mail(contact)
		@contact = contact
		mail(to:      @contact.user.email,
			from: 'adtanaka.taro1111@gmail.com',
			subject: "お問い合わせありがとうございます。")
	end
end
#binding.pry
