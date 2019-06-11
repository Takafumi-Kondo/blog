class Post < ApplicationRecord
	has_many :postimages, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	belongs_to :user
	belongs_to :genre
	belongs_to :emotion


#渡されたユーザidがfavoriteテーブル内に存在してるか
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
