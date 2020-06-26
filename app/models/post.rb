class Post < ApplicationRecord
  has_many :comments

  validates :title, presence: true

  accepts_nested_attributes_for :comments
end