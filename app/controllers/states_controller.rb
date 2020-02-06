class StatesController < ApplicationController
  before_action :set_state, only: [:show, :update, :destroy]

  # GET /states
  def index
    if params[:search]
      @state = State.search(params[:search])
      if @state.blank?
        render status: 200, json: {
          message: "No state found."
        }
      else
        render json: @state
      end
    else
    @states = State.all.sort_by { |s| [s.name]}

    render json: @states
  end
  end

  # GET /states/1
  def show
    render json: @state
  end

  # POST /states
  def create
    @state = State.new(state_params)

    if @state.save
      render json: @state, status: :created, location: @state
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /states/1
  def update
    if @state.update(state_params)
      render json: @state
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # DELETE /states/1
  def destroy
    @state.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def state_params
      params.require(:state).permit(:whats_needed, :primary, :absentee, :govenor, :govenor_phone, :voting_id, :id_needed, senator_attributes: [ :id, :name, :phone ], election_attributes: [:candidate, :party, :url, :running_for], ballot_measure_attributes: [:name, :sub_title, :info_page])
    end
end
