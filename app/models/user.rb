class User < ApplicationRecord
  has_many :scores, dependend: :destroy
end
