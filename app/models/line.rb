class Line < ActiveRecord::Base
  belongs_to :type_line

  has_many :line_stops, :dependent => :destroy
  has_many :stops, :through => :line_stops, :dependent => :destroy
  has_many :itineraries, :dependent => :destroy

  def code_name
    self.code + " - " + self.name
  end
end
