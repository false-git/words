class Wordset < ApplicationRecord
  belongs_to :group
  has_many :words, dependent: :destroy
end
