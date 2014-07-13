class PositionSerializer < ActiveModel::Serializer
  attributes :id, :to, :lat, :lng, :line_name

  def line_name
    object.line.name
  end
end
