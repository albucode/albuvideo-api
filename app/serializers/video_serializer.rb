class VideoSerializer < ActiveModel::Serializer
  attributes :title, :status, :published, :source, :id

  def id
    object.public_id
  end
end
