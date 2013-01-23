class Dependencia < ActiveRecord::Base
  validates_presence_of :nombre
end
