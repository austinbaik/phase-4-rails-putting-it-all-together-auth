class RecipesController < ApplicationController
  before_action :authorize

  def index
    recipe = Recipe.all
    render json: recipe
  end


  def create
    user = User.find_by(id: session[:user_id])
    recipe = user.recipes.create( recipe_params )
    # title: params[:title], minutes_to_complete: params[:minutes_to_complete], instructions: params[:instructions], user_id: session[:user_id]
    if recipe.valid?
      render json: recipe, status: :created
    else
      render json: { errors: [recipe.errors.full_messages] }, status: :unprocessable_entity
    end
  end


  def recipe_params
    params.permit(:title, :minutes_to_complete, :instructions ) 
# still need to pass the user_id as a param 
  end

  
  private

  def authorize
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end


end
