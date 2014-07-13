class SchedulesController < DestinationsController
  #TODO Store on database the access
  def index
    line = params['line_id']
    day = params['day_id']
    origin = params['origin_id']
    destination = params['destination_id']

    schedules = LineStopLineStop.by_line(line).by_day(day).by_origin(origin).by_destination(destination).first.schedules

    render :json => schedules
  end
end
