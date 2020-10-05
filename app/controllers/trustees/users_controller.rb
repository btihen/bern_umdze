class Trustees::UsersController < Trustees::ApplicationController

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
      redirect_to trustees_users_url, notice: 'User was successfully created.'
    else
      render :new, locals: {user: user}
    end
  end

  def edit
    user = User.new(user_params)

    render :edit, locals: {user: user}
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
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
      params.fetch(:user, {})
    end
end
