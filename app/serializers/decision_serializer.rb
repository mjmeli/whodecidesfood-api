class DecisionSerializer < ActiveModel::Serializer
  attributes :id, :meal, :location, :participant_id, :comparison_id, :created_at
end
