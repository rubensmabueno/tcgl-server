class LineStopSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.stop.name
  end
end
