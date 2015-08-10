class ProfileSerializer < ActiveModel::Serializer
  attributes :profile_type, :name
  has_many :children, root: :children, serializer: ChildSerializer
end
