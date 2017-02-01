class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :name, :score, :decision_ids
end
