class Comment < ApplicationRecord
	belongs_to :user, optional: true #nilを許可
	belongs_to :post

	#validates :comment, presence: true, length: {maximum: 150}
end
