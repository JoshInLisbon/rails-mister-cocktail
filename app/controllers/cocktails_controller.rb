class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.includes(:doses).order(created_at: :desc)
    @cocktail = Cocktail.new
    @dose = Dose.new

    ingredients = Ingredient.all
    @ingredient_names = []
    ingredients.each { |ing| @ingredient_names << ing.name }
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktails_path
    else
      render :index
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

end
