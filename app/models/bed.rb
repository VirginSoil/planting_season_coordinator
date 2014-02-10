class Bed

  attr_accessor :id, :name, :zipcode, :notes, :width, :depth, :user_id

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def persisted?
    false
  end

  def initialize(data = {})
    @id      = data["id"]
    @name    = data["name"]
    @zipcode = data["zipcode"]
    @notes   = data["notes"]
    @depth   = data["depth"]
    @width   = data["width"]
    @user_id = data["user_id"]
  end

  def self.client
    Faraday.new(:url => "http://localhost:8080")
  end



end
