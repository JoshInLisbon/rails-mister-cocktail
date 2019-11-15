Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'
  resources :cocktails, only: [:index, :create] do
    resources :doses, only: [:create]
  end
  # resources, think of a tree's routes... (roots), they are it's resources to help it
  # followed by plural, plural resources for routes, so plural thing after
end
# A user can see the list of cocktails
# GET "cocktails"


# A user can see the details of a given cocktail, with the dose needed for each ingredient
# GET "cocktails/42"
# # how about I make that all happen in one view?

# A user can create a new cocktail
# GET "cocktails/new"
# POST "cocktails"


# 4 - Routing, Controller, Views for Doses
# A user can add a new dose (ingredient/description pair) to an existing cocktail

# Checkout simple_form docs about f.association to easily create a select dropdown for our list of ingredients.
# GET "cocktails/42/doses/new"
# POST "cocktails/42/doses"
# # can I do this in the same view as the new cocktail?

# A user can delete a dose that belongs to an existing cocktail. How can we make a delete link again?
# DELETE "doses/25"

# Do we need an IngredientsController?


#            Prefix Verb URI Pattern                                 Controller#Action
#              root GET  /                                           cocktails#index
#    cocktail_doses GET  /cocktails/:cocktail_id/doses(.:format)     doses#index
#                   POST /cocktails/:cocktail_id/doses(.:format)     doses#create
# new_cocktail_dose GET  /cocktails/:cocktail_id/doses/new(.:format) doses#new
#         cocktails GET  /cocktails(.:format)                        cocktails#index
#                   POST /cocktails(.:format)                        cocktails#create
#      new_cocktail GET  /cocktails/new(.:format)                    cocktails#new
#          cocktail GET  /cocktails/:id(.:format)                    cocktails#show
