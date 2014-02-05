class BedsController < ApplicationController

  def new
    @bed = Bed.new
  end

  def create
    redirect_to :back
  end
end
