class Users::IndexSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :friends_count
end
