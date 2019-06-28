class Contact < ApplicationRecord
	belongs_to :user

	validates :title, length: { minium:4, maximum: 50 }
	validates :contact_content, length: { minium:10, maximum: 1000 }
end
