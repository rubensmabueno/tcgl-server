class ScheduleSerializer < ActiveModel::Serializer
  attributes :departure, :arrive, :via, :line

  def line
    object.line_stop_line_stop.origin.line.name
  end
end
