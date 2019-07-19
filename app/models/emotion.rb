class Emotion < ApplicationRecord
	has_many :posts

	validates :emotion_name, presence: true,
							 length: { maximum: 10 },
							 uniqueness: true #値がユニークか検証する
end
