class Word < ApplicationRecord
  belongs_to :wordset
  has_many :scores, dependent: :destroy
end
