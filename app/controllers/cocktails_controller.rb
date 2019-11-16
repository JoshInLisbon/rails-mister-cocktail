class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.includes(:doses).order(created_at: :desc)
    @cocktail = Cocktail.new
    @dose = Dose.new
    @ingredients = Ingredient.all

    # for ingredient error message
    @ingredient_error_msg = params[:ingredient_error_msg]
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

end
