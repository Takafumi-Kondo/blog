class Relationship < ApplicationRecord
	# フォローする側
	belongs_to :follower, class_name: "User"
	#される側
	belongs_to :following, class_name: "User"

	validates :follower_id, presence: true
	validates :following_id, presence: true

#belongs_to 変更したい親モデル名, class_name: "元々の親モデル名"。
#これでFollowモデル、Followerモデルを擬似的に作る。
end
