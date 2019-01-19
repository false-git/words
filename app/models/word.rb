class Word < ApplicationRecord
  belongs_to :wordset
  has_many :scores, dependend: :destroy
end
