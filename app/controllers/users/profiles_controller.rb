class Users::ProfilesController < ApplicationController

  def edit
    user = current_user

    render :edit, locals: {user: user}
  end

  def update
    user = current_user

    # if password blank then remove password and password_confirmation keys
    # Rails 6.1 added compact_blank: `user_params.compact_blank`
    update_params = user_params.reject{|_, v| v.blank?}

    if user.update(update_params)
      redirect_to root_path, notice: "User with email: #{user.email} was successfully updated."
    else

      render :edit, locals: {user: user}
    end
  end

  def destroy
    user  = current_user
    email = user.email
    user.destroy

    redirect_to landing_path, notice: "Your account and access with the email: #{user.email} is removed."
  end

  private

  def user_params
    params.require(:user).permit( :real_name, :username, :email,
                                  :password, :password_confirmation )
  end


end
