class Bed

  attr_accessor :id, :name, :zipcode, :notes, :width, :depth

  extend ActiveModel::Naming
  include ActiveModel::Conversion
 
  def persisted?
    false
  end

  def self.create

  end

  def initialize(data = {})
    @id      = data["id"]
    @name    = data["name"]
    @zipcode = data["zipcode"]
    @notes   = data["notes"]
    @depth   = data["depth"]
    @width   = data["width"]
  end



end
