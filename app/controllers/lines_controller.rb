class LinesController < ApplicationController
  def positions
    lines = Line.where(:id => params['line_ids'])
    positions = []

    lines.each do |line|
      position = GrandeLondrinaParser.position(line)
      positions << position if position.any?
    end

    render :json => positions
  end

  def itineraries
    itineraries = Line.find(params['id']).itineraries.order(:order)
    render :json => itineraries
  end

  def near_stops
    lines, radius = Itinerary.search_nearest(params['position'])
    render :json => [ lines, radius ]
  end
end
