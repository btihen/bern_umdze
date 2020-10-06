class Trustees::UsersController < Trustees::ApplicationController

  RolePermission = Struct.new(:role, :permissions)

  def index
    users      = User.all
    user_views = UserView.collection(users)

    render :index, locals: {users: user_views}
  end

  def new
    user  = User.new

    render :new, locals: {user: user}
  end

  def create
    # passwd = Digest::SHA256.bubblebabble(username).split('-').take(4).drop(1).join('-')
    # passwd = Devise.friendly_token(24)
    # params = user_params.merge(password: passwd, password_confirmation: passwd)
    params = user_params
    user   = User.new(params)

    # send_reset_password_instructions
    # # confirmation is needed or the password link doesn't work
    # self.confirmed_at      ||= DateTime.now
    # # set to nil at login and password link
    # self.passwd_link_sent_at = DateTime.now

    if user.save
      redirect_to trustees_users_url, notice: 'User was successfully created and login link sent.'
    else
      render :new, locals: {user: user}
    end
  end

  def edit
    user      = User.find(params[:id])
    user_view = UserView.new(user)

    render :edit, locals: {user: user, user_view: user_view}
  end

  def update
    user    = User.find(params[:id])
binding.pry
    # if password blank then remove password and password_confirmation keys
    params  = if user_params[:password].blank? && user_params[:password_confirmation].blank?
                user_params.delete(:password, :password_confirmation)
              else
                user_params
              end
    if user.update(params)
      redirect_to trustees_users_url, notice: 'User was successfully updated.'
    else
      render :edit, locals: {user: user}
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    redirect_to trustees_users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    # params.fetch(:user, {})
    params.require(:user)
          .permit(:real_name, :username, :email, :access_role,
                  :password, :password_confirmation)

  end

end
