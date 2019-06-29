class Genre < ApplicationRecord
  has_many :posts

  validates :genre_name, presence: true,
            length: { maximum: 50 },
            uniqueness: true
end
