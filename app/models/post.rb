class Post < ApplicationRecord
  has_many :postimages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  belongs_to :emotion

  attachment :post_headerimage

  is_impressionable counter_cache: true, unique: :all


    validates :title, presence: true, length: { maximum: 100 }
    validates :body, presence: true, length: { maximum: 10000 }

#渡されたユーザidがfavoriteテーブル内に存在してるか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)#selfはPost
    if search
      where(['title LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%"])
    else# SQL記述 %は0字以上の任意文字列
      all
    end
  end
end
