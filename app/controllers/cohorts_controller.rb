class CohortsController < ApplicationController

  skip_before_action :authenticate_cookie

  before_action :set_cohort, only: [:show, :update, :destroy]


  def index
    @cohorts = Cohort.all
    render json: @cohorts, include: "courses.units.lessons"
  end

  def search
    @cohorts = params[:name] ? Cohort.where("name ILIKE ?", "%#{params[:name]}%") :
    params[:description] ? Cohort.where("description ILIKE ?", "%#{params[:description]}%") : []

    render json: @cohorts, include: "courses.units.lessons"
  end

  def show
    if @cohort
      render json: @cohort, include: "courses.units.lessons"
    else
      error_json
    end
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      render json: { message: "Cohort created", cohort: @cohort }
    else
      error_json
    end
  end

  def update
    if @cohort.update(cohort_params)
      render json: { message: "Cohort updated", cohort: @cohort }
    else
      error_json
    end
  end

  def destroy
    if @cohort.destroy
      render json: { message: "Cohort deleted"}
    else
      error_json
    end
  end

  private

    def cohort_params
      params.require(:cohort).permit(:name, :description)
    end

    def set_cohort
      @cohort = Cohort.find(params[:id])
    end

    def error_json
      render json: { error: "Not Found" }, status: 404
    end

end
