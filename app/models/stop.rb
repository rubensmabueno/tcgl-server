class Stop < ActiveRecord::Base
  has_many :line_stops, :dependent => :destroy
  has_many :lines, :through => :line_stops, :dependent => :destroy
end
