class Participants::AttendeesController < Participants::ApplicationController
  before_action :set_attend, only: %i[ show edit update destroy ]

  # # GET /attends or /attends.json
  # def index
  #   @attendees = Attendee.all
  # end

  # # GET /attends/1 or /attends/1.json
  # def show
  # end

  # GET /attends/new
  def new
    @attendee = Attendee.new
  end

  # GET /attends/1/edit
  def edit
  end

  # POST /attends or /attends.json
  def create
    @attendee = Attend.new(attendee_params)

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to @attendee, notice: "Attend was successfully created." }
        format.json { render :show, status: :created, location: @attendee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attends/1 or /attends/1.json
  def update
    respond_to do |format|
      if @attend.update(attendee_params)
        format.html { redirect_to @attendee, notice: "Attend was successfully updated." }
        format.json { render :show, status: :ok, location: @attend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attends/1 or /attends/1.json
  def destroy
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to attendees_url, notice: "Attend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attend
      @attendee = Attendee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attend_params
      params.require(:attendee)
            .permit(:location, :user_id, :participant_id, :reservation_id)
    end
end
