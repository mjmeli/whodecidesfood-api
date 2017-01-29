class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :auth_token,
             :comparison_ids  # embed only the comparison IDs

  # Embed the entire comparison
  #has_many :comparisons
end
