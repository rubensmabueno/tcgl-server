require 'grande_londrina_parser'

namespace :populate do
  desc "Populate database with all information from Grande Londrina"
  task all: [:type_lines, :days, :lines, :stops, :schedules, :itineraries]

  desc "Populate the type of services from Grande Londrina"
  task type_lines: :environment do
    TypeLine.find_or_create_by(:name => 'Linhas Convencionais')
    TypeLine.find_or_create_by(:name => 'Linhas PSIU')

    puts 'Type lines created.'
  end

  desc "Populate the days from Grande Londrina"
  task days: :environment do
    Day.find_or_create_by(:name => 'SEMANA')
    Day.find_or_create_by(:name => 'SÁBADO')
    Day.find_or_create_by(:name => 'DOMINGO')

    puts 'Days created.'
  end

  desc "Populate the lines from Grande Londrina website"
  task lines: :environment do
    pbar = ProgressBar.new('Lines', TypeLine.count)
    old_lines_ids = Line.all.map(&:id)

    TypeLine.all.each do |type_line|
      lines_params = GrandeLondrinaParser.search_line(type_line)

      lines_params.each do |line_params|
        line = Line.find_or_initialize_by(line_params)
        line.type_line = type_line
        line.save

        old_lines_ids.delete(line.id)
      end

      pbar.inc
    end

    pbar.finish
    Line.destroy(old_lines_ids) if old_lines_ids.any?
  end

  desc "Populate the stops from Grande Londrina website"
  task stops: :environment do
    pbar = ProgressBar.new('Stops', Line.count)
    old_stops_ids = Stop.all.map(&:id)

    Line.all.each do |line|
      Day.all.each do |day|
        stops_params = GrandeLondrinaParser.search_stops(line, day)

        stops_params.each do |stop_params|
          stop = Stop.find_or_initialize_by(stop_params)
          stop.line_stops.build( :line => line, :day => day )
          stop.save!

          old_stops_ids.delete(stop.id)
        end
      end

      pbar.inc
    end

    pbar.finish
    Stop.destroy(old_stops_ids) if old_stops_ids.any?
  end

  desc "Populate the schedules from Grande Londrina website"
  task schedules: :environment do
    pbar = ProgressBar.new('Schedules', LineStop.count)
    old_line_stops_line_stops_ids = LineStopLineStop.all.map(&:id)

    LineStop.all.group_by(&:line).each do |line, line_stop_grouped_by_id|
      line_stop_grouped_by_id.group_by(&:day).each do |day, line_stop_grouped_by_id_and_date|
        line_stop_grouped_by_id_and_date.each do |line_stop_origin|
          ( line_stop_grouped_by_id_and_date - [ line_stop_origin ] ).each do |line_stop_destination|
            unless line_stop_destination.stop.nil? or line_stop_origin.stop.nil? or line.nil? or day.nil?
              schedules_params = GrandeLondrinaParser.search_schedules(line, day, line_stop_origin.stop, line_stop_destination.stop)

              line_stop_line_stop = LineStopLineStop.find_or_initialize_by(:origin => line_stop_origin, :destination => line_stop_destination)

              schedules_params.each do |schedules_param|
                line_stop_line_stop.schedules.build(schedules_param) unless schedules_param.blank?
              end

              line_stop_line_stop.save

              old_line_stops_line_stops_ids.delete(line_stop_line_stop.id)
            end
          end
        end
      end

      pbar.inc
    end

    pbar.finish
    LineStopLineStop.destroy(old_line_stops_line_stops_ids) if old_line_stops_line_stops_ids.any?
  end

  desc "Populate the itineraries from Grande Londrina website"
  task itineraries: :environment do
    pbar = ProgressBar.new('Itineraries', Line.count)
    old_itineraries_ids = Itinerary.all.map(&:id)

    Line.all.each do |line|
      itineraries_from_params, itineraries_to_params = GrandeLondrinaParser.search_itinerary(line)

      itineraries_from_params.each do |itinerary_from_params|
        itinerary_from = Itinerary.find_or_create_by(itinerary_from_params)

        old_itineraries_ids.delete(itinerary_from.id)
      end

      itineraries_to_params.each do |itinerary_to_params|
        itinerary_to = Itinerary.find_or_create_by(itinerary_to_params)

        old_itineraries_ids.delete(itinerary_to.id)
      end

      pbar.inc
    end

    pbar.finish
    Itinerary.destroy(old_itineraries_ids) if old_itineraries_ids.any?
  end

  # desc "TODO"
  # task reverse_geocode_itinerarios: :environment do
  #   pbar = ProgressBar.new("Itinerários", Itinerario.where(:endereco_id => nil).count)
  #   itinerario_anterior = nil
  #
  #   Itinerario.where(:endereco_id => nil).all.each do |itinerario|
  #     endereco_endereco = Geokit::Geocoders::GoogleGeocoder.reverse_geocode(itinerario.lat.to_s + ',' + itinerario.lng.to_s)
  #     raise endereco_endereco.all.inspect
  #
  #     #puts endereco_endereco.full_address
  #     endereco_endereco = endereco_endereco
  #
  #     endereco = Address.find_or_create_by_rua_and_numero(:street => endereco_endereco.street_name, :number => endereco_endereco.street_number, :postal_code => endereco_endereco.zip)
  #     endereco.bairro_id = Neighbourhood.find_or_create_by_nome(:name => endereco_endereco.neighborhood).id
  #     endereco.cidade_id = City.find_or_create_by_nome(:name => endereco_endereco.city).id
  #     endereco.estado_id = State.find_or_create_by_nome(:name => endereco_endereco.state).id
  #     endereco.save!
  #
  #     itinerario.endereco = endereco
  #     itinerario.distancia = itinerario.distance_to(itinerario_anterior) unless itinerario_anterior.nil?
  #     itinerario.save!
  #
  #     itinerario_anterior = itinerario
  #     pbar.inc
  #   end
  #
  #   pbar.finish
  # end
end
