class Access < ActiveRecord::Base
  has_many :accesses_line_stops, :dependent => :destroy

  accepts_nested_attributes_for :accesses_line_stops

  after_initialize :build_accesses_line_stops

  def build_accesses_line_stops
    self.accesses_line_stops.build unless self.accesses_line_stops.any?
  end
end
