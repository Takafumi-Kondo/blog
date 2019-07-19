class Genre < ApplicationRecord
  has_many :posts

  validates :genre_name, presence: true,
            length: { maximum: 12 },
            uniqueness: true
end
