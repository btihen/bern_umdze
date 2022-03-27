# frozen_string_literal: true

module Participants
  class ProfilesController < Participants::ApplicationController
    # before_action :set_participant, only: %i[ show edit update destroy ]

    def edit
      participant = set_participant

      render :edit, locals: { participant: }
    end

    def update
      participant = set_participant
      participant.assign_attributes(participant_params)

      if !participant_params[:fullname].blank? && participant.save
        redirect_to participants_home_path, notice: "#{participant.fullname}, was successfully updated."
        # format.json { render :show, status: :ok, location: @participant }
      else

        flash[:alert] = 'Eine Name ist nötig'
        render :edit, locals: { participant: } # , status: :unprocessable_entity
        # format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end

    def destroy
      participant = set_participant
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

    def set_participant
      current_participant(session[:login_token])
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:fullname)
    end
  end
end
