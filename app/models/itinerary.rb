class Itinerary < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  belongs_to :address
  belongs_to :stop
  belongs_to :line

  def self.search_nearest(position)
    latLng = [ position[:lat], position[:lng] ]
    radius = 0.1
    lines_id = self.within(0.1, :units => :kms, :origin => latLng).pluck(:line_id).uniq

    unless lines_id.any?
      radius = 0.3
      lines_id = self.in_range(0.1..0.3, :units => :kms, :origin => latLng).pluck(:line_id).uniq

      unless lines_id.any?
        itineraries = self.by_distance(:units => :kms, :origin => latLng).limit(3)
        radius = itineraries.first.distance_to(latLng)
        lines_id = itineraries.pluck(:line_id).uniq
      end
    end

    lines = Line.where(:id => lines_id)
    [lines, radius]
  end
end
