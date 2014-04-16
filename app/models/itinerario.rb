class Itinerario < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :default_formula => :flat,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  belongs_to :endereco
  belongs_to :ponto
  belongs_to :linha

  def color
    case self[:sentido]
      when 0
        '#428bca'
      when 1
        '#8a6d3b'
      when 2
        '#31708f'
      when 3
        '#3c763d'
      else
        '#a94442'
    end
  end
end
