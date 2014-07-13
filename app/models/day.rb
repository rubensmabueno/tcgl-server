class Day < ActiveRecord::Base
  has_many :line_stops, :dependent => :destroy

  scope :by_line, -> (line) { joins(:line_stops).where(:line_stops => { :line_id => line }).uniq }

  default_scope { order(:id) }
end
