class Address < ActiveRecord::Base
  belongs_to :neighbourhood
  belongs_to :city
  belongs_to :state
end
