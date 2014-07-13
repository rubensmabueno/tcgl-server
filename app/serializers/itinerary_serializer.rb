class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :line_id, :to, :order, :color

  def color
    "%06x" % (rand * 0xffffff)
  end
end
