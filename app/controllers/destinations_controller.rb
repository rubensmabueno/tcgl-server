class DestinationsController < OriginsController
  def index
    line = params['line_id']
    day = params['day_id']
    origin = params['origin_id']

    destinations = LineStop.by_line(line).by_day(day).by_origin(origin)

    render :json => [ destinations ]
  end
end