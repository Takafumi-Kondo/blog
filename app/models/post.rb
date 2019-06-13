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

	def self.search(search)#selfはPosr
		if search
			where(['body LIKE ?', "%#{search}%"])#検索内とnameの部分一致を表示
		else# SQL記述 %は0字以上の任意文字列
			all
		end
	end
end
