class Trustees::UsersController < Trustees::ApplicationController

  RolePermission = Struct.new(:role, :permissions)

  def index
    users      = User.all
    user_views = UserView.collection(users)

    render :index, locals: {users: user_views}
  end

  def new
    user = User.new

    render :new, locals: {user: user}
  end

  def create
    user = User.new(user_params)

    if user.save
      redirect_to trustees_users_path, notice: "User with email: #{user.email} was successfully created."
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
    user = User.find(params[:id])
# binding.pry
    # if password blank then remove password and password_confirmation keys
    params  = if user_params[:password].blank? && user_params[:password_confirmation].blank?
                user_params.delete(:password, :password_confirmation)
              else
                user_params
              end
    if user.update(params)
      redirect_to trustees_users_path, notice: "User with email: #{user.email} was successfully updated."
    else
      render :edit, locals: {user: user}
    end
  end

  def destroy
    user  = User.find(params[:id])
    email = user.email
    user.destroy

    redirect_to trustees_users_path, notice: "User with email: #{user.email} was successfully deleted."
  end

  private

  def user_params
    params.require(:user)
          .permit(:real_name, :username, :email, :access_role,
                  :password, :password_confirmation)
  end

end
