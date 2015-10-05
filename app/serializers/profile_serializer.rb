class ProfileSerializer < ActiveModel::Serializer
  attributes :profile_type, :name, :id, :gender, :cell_phone
  has_many :children, root: :children, serializer: ChildSerializer
end
