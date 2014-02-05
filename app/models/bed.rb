class Bed

  attr_accessor :id, :name, :zipcode, :notes, :width, :depth

  extend ActiveModel::Naming
  include ActiveModel::Conversion
 
  def persisted?
    false
  end

  def self.create(attributes)
    status, data = client.post do |req|
      req.url '/beds'
      req.headers['Content-Type'] = 'application/json'
      req.body = attributes.as_json
    end
    [status, new(data)]
  end

  def initialize(data = {})
    @id      = data["id"]
    @name    = data["name"]
    @zipcode = data["zipcode"]
    @notes   = data["notes"]
    @depth   = data["depth"]
    @width   = data["width"]
  end

  def self.client
    Faraday.new(:url => "http://localhost:8080/api/v1")
  end



end
