class GuestSerializer < ActiveModel::Serializer
  attributes :id, :name, :occupation
  has_many :episodes
  has_many :appearances
end
