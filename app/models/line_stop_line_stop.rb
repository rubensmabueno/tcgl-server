class LineStopLineStop < ActiveRecord::Base
  belongs_to :origin, :class_name => 'LineStop'
  belongs_to :destination, :class_name => 'LineStop'

  has_many :schedules, :dependent => :destroy

  scope :by_origin, -> (origin) { where( :origin_id => origin ) }
  scope :by_destination, -> (destination) { where( :destination_id => destination ) }

  def self.by_line(line)
    joins(:origin).where(:line_stops => { :line_id => line } )
  end

  def self.by_day(day)
    joins(:origin).where(:line_stops => { :day_id => day } )
  end
end
