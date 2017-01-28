class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :auth_token,
             :comparison_ids

  # Embed the entire comparison
  #has_many :comparisons

  # Embed only the comparison IDs for performance
  def comparison_ids
    object.comparisons.pluck(:id)
  end
end
