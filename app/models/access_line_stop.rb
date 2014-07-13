class AccessLineStop < ActiveRecord::Base
  belongs_to :line
  belongs_to :day
  belongs_to :origin, :class_name => "LineStop", :foreign_key => :origin_id
  belongs_to :destination, :class_name => "LineStop", :foreign_key => :destination_id

  belongs_to :access

  def schedules
    LineStopLineStop.joins(:origin, :destination).
        where(:origin => { :line_id => self.line_id, :day_id => self.day_id, :stop_id => self.origin_id }).
        where(:destination => { :stop_id => self.destination_id }).first.schedules

    # LineStopLineStop.joins('INNER JOIN linhas_pontos origem ON origem.id = linhas_pontos_linhas_pontos.origem_id')
    # .joins('INNER JOIN linhas_pontos destino ON destino.id = linhas_pontos_linhas_pontos.destino_id')
    # .where(:origin => { :linha_id => self.linha_id, :dia_id => self.dia_id, :ponto_id => self.origem_id })
    # .where(:destination => { :ponto_id => self.destino_id}).first.schedules
  end
end
