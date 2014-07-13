class LineStop < ActiveRecord::Base
  belongs_to :line
  belongs_to :stop
  belongs_to :day

  has_many :line_stops_line_stops, :dependent => :destroy, :foreign_key => :origin_id
  has_many :destinations, :through => :line_stops_line_stops, :dependent => :destroy

  default_scope { order( :id ) }

  scope :by_line, -> (line) { where( :line_id => line ) }
  scope :by_day, -> (day) { where( :day_id => day ) }

  def self.by_origin(origin)
    #TODO Refactor this, remove the uniq
    joins(:line_stops_line_stops).where( :line_stops_line_stops => { :destination_id => origin } )
  end
end
