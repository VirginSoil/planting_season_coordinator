class BedsController < ApplicationController

  def new
    @bed = Bed.new
  end

  def create
    status, @bed = Bed.create(params[:bed])
    if status == 201
      flash[:success] = "YOU WIN!"
      redirect_to beds_path
    else
      flash[:error] = "LAME."
      render :new
    end 
  end
end
