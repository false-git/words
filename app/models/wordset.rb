class Wordset < ApplicationRecord
  has_many :words, dependend: :destroy
end
