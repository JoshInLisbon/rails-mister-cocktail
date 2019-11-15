class DosesController < ApplicationController
  def create

    # to do, route with variable not params after error?
    # stop auto complete on forms
    # alphabetical ingredients
    # ajax / not to reload

    @dose = Dose.new(dose_params)
    @cocktail_w_ingredient = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail_w_ingredient
    # @dose.ingredient = @ingredient

    if @dose.save
      # flash[:error] = 'SUPER ERRROR'
      redirect_to root_path,
      notice: "#{@dose.description} of #{@dose.ingredient.name} added to #{@cocktail_w_ingredient.name}"
    else
      # flash[:error] = 'SUPER ERRROR'
      # flash[:success] = 'SUPER ERRROR'
      # flash[:notice] = 'SUPER ERRROR'
      # flashp[:hello_anything_else] = 'hello'
      # uses same flash keys... as bootstrap, warning, error, success
      # so if have flash
      ingredient_error_msg = "#{@dose.ingredient.name} NOT added to #{@cocktail_w_ingredient.name}. No description given."
      redirect_to root_path(ingredient_error_msg: ingredient_error_msg)
      # index_instance_variables
      # render template: 'cocktails/index'#,
      # these are called flash messages
      # notice... he does not use
      # its new
      # set a flash something, make new method

    end
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
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
