class Playlist < ActiveRecord::Base
  has_many :tracks

  validates :name, presence: true
end