class CocktailsController < ApplicationController
  def index
    index_instance_variables
    @cocktail = Cocktail.new
    # for ingredient error message
    @ingredient_error_msg = params[:ingredient_error_msg]
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to root_path
    else
      index_instance_variables
      render :index
    end
  end

  private

  def index_instance_variables
    @cocktails = Cocktail.includes(:doses).order(created_at: :desc)
    @dose = Dose.new
    @ingredients = Ingredient.all
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

end
