class Managers::UsersController < Managers::ApplicationController

  def index
    users      = User.all.order(real_name: :asc)
    user_views = UserView.collection(users)

    render :index, locals: {users: user_views}
  end

  def new
    user = User.new

    render :new, locals: {user: user}
  end

  def create
    # Rails 6.1 added compact_blank: `user_params.compact_blank`
    # https://stackoverflow.com/questions/812541/how-to-change-hash-values
    create_params  = user_params.reject{|_, v| v.blank?}    # remove fields that are blank (don't update blank passwords)
                                .transform_values(&:squish) # should be safe for all param values are strings (use strip if it includes text fields)
    user = User.new(create_params)

    if user.save
      redirect_to managers_users_path, notice: "User with email: #{user.email} was successfully created."
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
    # Rails 6.1 added compact_blank: `user_params.compact_blank`
    # https://stackoverflow.com/questions/812541/how-to-change-hash-values
    update_params  = user_params.reject{|_, v| v.blank?}    # remove fields that are blank (don't update blank passwords)
                                .transform_values(&:squish) # should be safe for all param values are strings (use strip if it includes text fields)
    user = User.find(params[:id])
    user_view = UserView.new(user)

    if user.update(update_params)
      redirect_to managers_users_path, notice: "User with email: #{user.email} was successfully updated."
    else
      render :edit, locals: {user: user, user_view: user_view}
    end
  end

  def destroy
    user  = User.find(params[:id])
    email = user.email
    user.destroy

    redirect_to managers_users_path, notice: "User with email: #{user.email} was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit( :real_name, :username, :email, :access_role,
                                  :status, :password, :password_confirmation )
  end

end
