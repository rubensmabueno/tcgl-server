class Schedule < ActiveRecord::Base
  belongs_to :line_stop_line_stop

  default_scope { order(:departure) }
end
