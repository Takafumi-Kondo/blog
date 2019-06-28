class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
# フォローする側(active_relationships)擬似的に作成。foreign_keyでされる側id指定している
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
#フォローしているユーザーを取り出す
  has_many :following, through: :active_relationships
# フォローされてるユーザーを取り出せる(user.followers)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_relationships

  attachment :profile_image
  attachment :profile_headerimage

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 150 }
  validates :email, presence: true, length: { maximum: 80 }


# フォロー関連
  def follow(other_user)
    active_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end
	# フォローしているかどうか(t or f)
  def following?(other_user)
    following.include?(other_user)
  end

# 検索関連
  def self.search(search)#selfはUser
    if search
      where(['name LIKE ?', "%#{search}%"])#検索内とnameの部分一致を表示
    else# SQL記述 %は0字以上の任意文字列
      all
    end
  end
end
