class Users::AttendeesController < Users::ApplicationController
  before_action :set_attendee, only: %i[ show edit update destroy ]

  # def index
  #   @attendees = attendee.all
  # end

  # def show
  # end

  def new
    @attendee = attendee.new
  end

  def edit
  end

  def create
    @attendee = attendee.new(attendee_params)

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to @attendee, notice: "attendee was successfully created." }
        format.json { render :show, status: :created, location: @attendee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attendee.update(attendee_params)
        format.html { redirect_to @attendee, notice: "attendee was successfully updated." }
        format.json { render :show, status: :ok, location: @attendee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to attendees_url, notice: "attendee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendee
      @attendee = attendee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendee_params
      params.require(:attendee).permit(:location, :participant_id, :reservation_id)
    end
end
