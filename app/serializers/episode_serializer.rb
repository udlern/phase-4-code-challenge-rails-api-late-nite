class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :date, :number
  has_many :guests
  has_many :appearances
end
