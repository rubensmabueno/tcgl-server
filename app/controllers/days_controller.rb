class DaysController < ApplicationController
  def index
    line = params['line_id']

    days = Day.by_line(line)
    origins = LineStop.by_line(line).by_day(days.first.id)
    destinations = LineStop.by_line(line).by_day(days.first.id).by_origin(origins.first.id)

    render :json => [ days, origins, destinations ]
  end
end
