class AppearanceSerializer < ActiveModel::Serializer
  attributes :id, :rating
  belongs_to :episode
  belongs_to :guest
end
