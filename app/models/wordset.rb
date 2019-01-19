class Wordset < ApplicationRecord
  has_many :words, dependent: :destroy
end
