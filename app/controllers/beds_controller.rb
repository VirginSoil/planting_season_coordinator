class BedsController < ApplicationController
  def index
    @beds = current_users_beds
    session[:default_bed] ||= default_bed['id']
  end

  def show
    make_sure_shes_got_a_bed
    decide_which_bed_to_use
    session[:current_bed] = @bed['id']
    @next, @prev = MiracleGrow::Bed.find_neighbors(@bed, cookies[:user_id])
    @plant_names = MiracleGrow::Plant.all_plant_names
    @all_plants = MiracleGrow::Plant.all_the_plants
    @plantings = MiracleGrow::Planting.plantings_for_bed(@bed['id'])
    @taken_spots = MiracleGrow::Planting.taken(@bed['id'])
  end

  def new
    @bed = Bed.new
    @current_user_id = cookies[:user_id]
  end

  def edit
    attrs = MiracleGrow::Bed.find_bed(params[:id])
    @bed = Bed.new(attrs)
    @current_user_id = cookies[:user_id]
  end

  def update
    MiracleGrow::Bed.patch_bed(params)
    redirect_to beds_path, :notice => "Got er done!"
  end

  def create
    response = MiracleGrow::Bed.create_bed(params)

    if response.status == 201
      flash[:success] = "YOU WIN!"
      redirect_to root_path
    else
      @bed = Bed.new
      flash[:error] = "You fargin' failed buddy."
      render 'beds/new', :notice => "Error Will Robinson!"
    end
  end

  private

  def make_sure_shes_got_a_bed
    unless MiracleGrow::Bed.current_users_beds(cookies[:user_id]).length > 0
      redirect_to new_bed_path, :notice => "Please create a bed first!"
    end
  end

  def decide_which_bed_to_use
    if params[:bed] && params[:bed][:bed_id]
      @bed = show_bed(params[:bed][:bed_id])
    elsif params[:id]
      @bed = show_bed(params[:id])
    else
      @bed = MiracleGrow::Bed.default_bed(cookies[:user_id])
    end
  end

end