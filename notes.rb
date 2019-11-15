Attributes
A cocktail has a name (e.g. "Mint Julep", "Whiskey Sour", "Mojito")
# rails g model cocktail name

An ingredient has a name (e.g. "lemon", "ice", "mint leaves")
# rails g model ingredient name

A dose is the amount needed for each ingredient in a cocktail (e.g. the Mojito cocktail needs 6cl of lemon). So each dose references a cocktail, an ingredient and has a description.
# rails g model dose description cocktail:reference ingredient:reference
# WRONG... always singular!

From other exercise
# rails g model review content rating:integer restaurant:references



Associations
A cocktail has many doses
A cocktail has many ingredients through doses
An ingredient has many doses

A dose belongs to an ingredient
A dose belongs to a cocktail

You can’t delete an inmgredient if it used by at least one cocktail.

When you delete a cocktail, you should delete associated doses (but not the ingredients as they can be linked to other cocktails).


Validation
A cocktail must have a unique name.
An ingredient must have a unique name.
A dose must have a description, a cocktail and an ingredient, and [cocktail, ingredient] pairings should be unique.


Features
Once again, you must have a precise idea of the features of your app in order to build your routes. Here is the list of features:

A user can see the list of cocktails
GET "cocktails"


A user can see the details of a given cocktail, with the dose needed for each ingredient
GET "cocktails/42"
# how about I make that all happen in one view?

A user can create a new cocktail
GET "cocktails/new"
POST "cocktails"


4 - Routing, Controller, Views for Doses
A user can add a new dose (ingredient/description pair) to an existing cocktail

Checkout simple_form docs about f.association to easily create a select dropdown for our list of ingredients.
GET "cocktails/42/doses/new"
POST "cocktails/42/doses"
# can I do this in the same view as the new cocktail?

A user can delete a dose that belongs to an existing cocktail. How can we make a delete link again?
DELETE "doses/25"

Do we need an IngredientsController?


# heroku

> heroku login

> heroku create mr-cocktail-9000 --region eu

> git remote -v

# now have two remote repositories
# origin (github)
# heroku (heroku)

heroku  https://git.heroku.com/mr-cocktail-9000.git (fetch)
heroku  https://git.heroku.com/mr-cocktail-9000.git (push)
origin  git@github.com:JoshInLisbon/rails-mister-cocktail.git (fetch)
origin  git@github.com:JoshInLisbon/rails-mister-cocktail.git (push)

share: git push origin master
deploy: git push heroku master

master is BRANCH name

to push:

> git push heroku master

> heroku run rails db:migrate

# remember you need to include rails
# heroku has lots of customers on different software tools
# so need to use rails




