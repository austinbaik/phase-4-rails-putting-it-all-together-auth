class UsersController < ApplicationController
  before_action :authorize, except: :create

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id #still don't quite understand this
      #   Sessions work behind the scenes because of the bycrypt gem. We don't need to pass session within the render json, because session will be an object that connects with the application when you install the gem

      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def log_in
    user = User.find_by(id: session[:user_id])
    # if user&.authenticate(params[:password])
    #   session[:user_id] = user.id
      render json: user
    # else
    #   render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    # end
  end

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end

  private

  def authorize
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end
end
