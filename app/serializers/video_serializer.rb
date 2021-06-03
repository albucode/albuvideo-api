class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :published, :source, :public_id
end
