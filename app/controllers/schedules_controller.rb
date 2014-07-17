class SchedulesController < DestinationsController
  #TODO Store on database the access
  def index
    line = params['line_id']
    day = params['day_id']
    origin = params['origin_id']
    destination = params['destination_id']

    schedules = LineStopLineStop.by_line(line).by_day(day).by_origin(origin).by_destination(destination).first.schedules

    AccessLogWorker.perform_async({ip: request.remote_ip,
                                   line_id: line,
                                   day_id: day,
                                   origin_id: origin,
                                   destination_id: destination})

    render :json => schedules
  end
end
