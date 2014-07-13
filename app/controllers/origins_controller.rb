class OriginsController < DaysController
  def index
    line = params['line_id']
    day = params['day_id']

    origins = LineStop.by_line(line).by_day(day)
    destinations = LineStop.by_line(line).by_day(day).by_origin(origins.first.id)

    render :json => [ origins, destinations ]
  end
end