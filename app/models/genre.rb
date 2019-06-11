class Genre < ApplicationRecord
	has_many :posts

=begin
	validates :genre_name, presence: true,
						   length: {maximum: 20},
						   uniqueness: true #値がユニークか検証する
=end
end
