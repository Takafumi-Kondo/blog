ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	address: 'smtp.gmail.com',
    port: 587,
    domain: 'smtp.gmail.com',
    user_name: 'adtanaka.taro1111@gmail.com',
    password: "szvtnzwlapdqlpfv",
    authentication: 'plain',
    enable_starttls_auto: true
}
