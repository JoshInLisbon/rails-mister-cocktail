class DosesController < ApplicationController
  def create

    # to do, route with variable not params after error?
    # alphabetical ingredients
    # ajax / not to reload

    @dose = Dose.new(dose_params)
    @cocktail_w_ingredient = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.find(params[:dose][:ingredient])
    @dose.cocktail = @cocktail_w_ingredient
    @dose.ingredient = @ingredient

    if @dose.save
      redirect_to root_path,
      notice: "#{@dose.description} of #{@ingredient.name} added to #{@cocktail_w_ingredient.name}"
    else
      ingredient_error_msg = "#{@ingredient.name} NOT added to #{@cocktail_w_ingredient.name}. No description given."
      redirect_to root_path(ingredient_error_msg: ingredient_error_msg)
      # index_instance_variables
      # render template: 'cocktails/index'#,
    end
  end

  private

  def dose_params
    params.require(:dose).permit(:description)
  end

  def index_instance_variables
    @cocktails = Cocktail.includes(:doses).order(created_at: :desc)
    @cocktail = Cocktail.new
    @dose = Dose.new
    @ingredients = Ingredient.all
  end
end

# => "dose"=>{"ingredient"=>"402", "description"=>"44ml"},
#{}"commit"=>"Create Dose", "controller"=>"doses", "action"=>"create",
#{}"cocktail_id"=>"23"} permitted: false>
