class Participants::ProfilesController < Participants::ApplicationController
  # before_action :set_participant, only: %i[ show edit update destroy ]

  def edit
    participant = current_participant(session[:login_token])
    respond_to do |format|
      format.html { render :edit, locals: {participant: participant} }
      # format.json { render :show, status: :ok, location: @participant }
    end
  end

  def update
    participant = current_participant(session[:login_token])
    participant.assign_attributes(participant_params)
    if participant.save
      redirect_to participants_home_path, notice: "#{participant.fullname}, was successfully updated."
      # format.json { render :show, status: :ok, location: @participant }
    else
      render :edit, locals: {participant: participant}, status: :unprocessable_entity
      # format.json { render json: @participant.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    participant = current_participant(session[:login_token])
    fullname = participant.fullname
    participant.destroy
    session[:participant] = nil
    session[:login_token] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: "#{fullname}, was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_participant
    #   @participant = Participant.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:fullname)
    end
end
