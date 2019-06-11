class Contact < ApplicationRecord
	belongs_to :user

=begin
	with_options presence: true do
		validates :title, length: {minium:4, maximum: 50}
		validates :contact_content, length: {maximum: 1000}
	end
=end
end
