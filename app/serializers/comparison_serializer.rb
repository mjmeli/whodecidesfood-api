class ComparisonSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_one :owner # put the owner in the json response for now
end
