class ComparisonSerializer < ActiveModel::Serializer
  attributes :id, :title, :owner
  # has_many :participants, serializer: CompactParticipantSerializer
  attributes :participants
  attribute :decision_ids

  # Put the owner in the json response, but use the compact owner serializer
  def owner
    CompactUserSerializer.new(object.owner)
  end

  # Order participants by created date
  def participants
    object.participants.order("created_at").map{ |p|
      CompactParticipantSerializer.new(p)
    }
  end

  # has_one :owner # put the owner in the json response for now
end
