class DaySerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :today

  def today
    if Date.today.wday == 0 and object.id == 3
      true
    elsif Date.today.wday < 6 and object.id == 1
      true
    elsif Date.today.wday == 6 and object.id == 2
      true
    else
      false
    end
  end
end
