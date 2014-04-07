class Dia < ActiveRecord::Base
  has_many :linhas_pontos

  default_scope order(:id)

  def today
    if Date.today.wday == 0 and self.id == 3
      true
    elsif Date.today.wday < 6 and self.id == 1
      true
    elsif Date.today.wday == 6 and self.id == 2
      true
    else
      false
    end
  end
end
