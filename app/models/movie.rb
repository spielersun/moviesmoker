class Movie < ActiveRecord::Base
    has_many :title_votes, dependent: :destroy
    has_many :watcheds, dependent: :destroy
    has_many :wishlsts, dependent: :destroy
    has_many :bnndlsts, dependent: :destroy
    validates :name, presence: true, length: {minimum: 5}
end
