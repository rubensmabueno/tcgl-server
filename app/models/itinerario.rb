class Itinerario < ActiveRecord::Base
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
