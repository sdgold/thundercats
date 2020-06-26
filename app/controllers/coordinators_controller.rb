require 'pry'

class CoordinatorsController < ApplicationController
  before_action :set_coordinator, only: [:show, :edit, :update, :destroy]

  # GET /coordinators
  # GET /coordinators.json
  def index
    @coordinators = Coordinator.all
    @workers = Worker.all.sample(20).sort
  end

  # GET /coordinators/1
  # GET /coordinators/1.json
  def show
  end

  # GET /coordinators/new
  def new
    @coordinator = Coordinator.new
    @coordinator.subordinates.build
    # @workers = Worker.all.sample(20).sort
    @subordinates = Worker.all.sample(20).sort
  end

  # GET /coordinators/1/edit
  def edit
  end

  # POST /coordinators
  # POST /coordinators.json
  def create
    @coordinator = Coordinator.new(coordinator_params)

    respond_to do |format|
      if @coordinator.save
        format.html { redirect_to @coordinator, notice: 'Coordinator was successfully created.' }
        format.json { render :show, status: :created, location: @coordinator }
      else
        format.html { render :new }
        format.json { render json: @coordinator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coordinators/1
  # PATCH/PUT /coordinators/1.json
  def update
    respond_to do |format|
      if @coordinator.update(coordinator_params)
        format.html { redirect_to @coordinator, notice: 'Coordinator was successfully updated.' }
        format.json { render :show, status: :ok, location: @coordinator }
      else
        format.html { render :edit }
        format.json { render json: @coordinator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coordinators/1
  # DELETE /coordinators/1.json
  def destroy
    @coordinator.destroy
    respond_to do |format|
      format.html { redirect_to coordinators_url, notice: 'Coordinator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coordinator
      @coordinator = Coordinator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coordinator_params
      # params.require(:coordinator).permit(:name, :coordinator_worker_ids)
      params.require(:coordinator).permit!
      # params.require(:post).permit(:title, comments_attributes: [:body])
      # params.require(:coordinator).permit(:name, workers_attributes: [:name])
    end
end
