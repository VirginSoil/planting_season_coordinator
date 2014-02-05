class BedsController < ApplicationController
  def new
    @bed = Bed.new
  end
end
