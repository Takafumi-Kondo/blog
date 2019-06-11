class Postimage < ApplicationRecord
	belongs_to :post
	attachment :image
end
