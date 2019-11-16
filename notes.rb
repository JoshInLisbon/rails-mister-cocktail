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


see 'https://kitt.lewagon.com/camps/312/lectures/05-Rails%2F05-Rails-MC-with-images#/0/4/3'
for images info

  We don't want to share those secret keys on Github, we can use the dotenv gem for security.

  # Gemfile
  gem 'dotenv-rails', groups: [:development, :test]
  bundle install
  touch .env
  echo '.env*' >> .gitignore
  git status # .env should not be there, we don't want to push it to Github.
  git add .
  git commit -m "Add dotenv - Protect my secret data in .env file"

  CLOUDINARY & ENVIRONMENT
  # Gemfile
  gem 'cloudinary', '~> 1.9.1'
  bundle install
  # .env
  CLOUDINARY_URL=cloudinary://298522699261255:Qa1ZfO4syfbOC-***********************8

  <!-- app/views/articles/index.html.erb -->
  <%= cl_image_tag("THE_IMAGE_ID_FROM_LIBRARY",
        width: 400, height: 300, crop: :fill) %>

  <!-- for face detection -->
  <%= cl_image_tag("IMAGE_WITH_FACE_ID",
        width: 150, height: 150, crop: :thumb, gravity: :face) %>'

# and also

<%= cl_image_url("THE_IMAGE_ID_FROM_LIBRARY") %> gives the url

# example:
<%= cl_image_tag('gmewp8rcecg7fqakys96',
      width: 400, height: 300, crop: :fill) %>
>

# CARRIERWAVE

# It's a gem to upload files associated to Models.
# Gemfile
gem 'carrierwave', '~> 1.2'

# in terminal
> bundle install

# restart rails server

# create an uploader
# in terminal
> rails g uploader Photo
# An Uploader came from
# carrierwave gem
gem 'carrierwave', '~> 1.2'
# it tells to carrierwave
# how to handle the files.
# In short, it contained all:
# file processing functionalities.
# Run the command to create an uploader

# Now open the resume model and call the uploader as shown below. Resume model has placed at app/models/resume.rb −

# check your files for:
# app/uploaders

# if you don't find
# then we do
> spring stop
# in the terminal

# so carrierwave is not related to
# cloudinary
# it is a gem just for easy uploading
# as in users uploading documents / info

# https://github.com/carrierwaveuploader/carrierwave
# https://www.rubydoc.info/github/jnicklas/carrierwave/CarrierWave%2FMount:mount_uploader

# you need to configure the uploader to connect it to
cloudinary

include Cloudinary::CarrierWave
# in the PhotoUploader (photo_uploader.rb)
# you can comment out / remove everythign else


# ALTERING THE MODEL


# then you need to alter the model because right now
# the model does not have an image associated to it
# it is a string, because the image is a code like this
'gmewp8rcecg7fqakys96'
# so we need to add a string to the model
> rails g migration AddPhotoToCocktails photo:string
# this just makes a migration file, we need to migrate to impact the schema

# here we can see how Photo corresponds to
> rails g uploader Photo # the 'Photo' part

# now I need to run
> rails db:migrate

# this has not updated the model, just the schema

create_table "cocktails", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.string "photo"

# so we need to add a mount uploader to the model
# for the photo string
# good info on mount uploader : https://www.rubydoc.info/github/jnicklas/carrierwave/CarrierWave%2FMount:mount_uploader
# Mounts the given uploader on the given column.
# This means that assigning and reading from the
# column will upload and retrieve files.

# Supposing that a User class has an uploader
# mounted on image, you can assign and retrieve files like this:

@user.image # => <Uploader>
@user.image.store!(some_file_object)

@user.image.url # => '/some_url.png'

# in the model
mount_uploader :photo, PhotoUploader
# so we have

class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  mount_uploader :photo, PhotoUploader

  validates :name, uniqueness: true, presence: true
end

# now it exists, we have to let the user upload it
<div class="collapse mb-3" id="collapseExample">
  <div class="card card-body">
    <%= simple_form_for @cocktail, html: { autocomplete: 'off' } do |f| %>
      <%= f.input :name, label: 'Cocktail name' %>

      # > PHOTO STUFF HERE
      <%= f.input :photo %>
      <%= f.input :photo_cache, as: :hidden %>
      # the last line saves the photo as a param, so if there is an error we can return the user
      # to a page with the photo filled in as it exists as a param (:photo_cache)

      <%= f.submit class: 'btn btn-primary' %>
    <% end %>
  </div>
</div>
# we do this by updating our simple_form_for

class Cocktail < ApplicationRecord
  # before_create :default_photo
  # this is meant to work before .save too, but not sure

  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, uniqueness: true, presence: true

  mount_uploader :photo, PhotoUploader


  # so I was thinking of having a private method
  # to set a defalt photo, but firstly a photo is complex
  # not 'gmewp8rcecg7fqakys96'
  # it is
  # "photo"=>#<ActionDispatch::Http::UploadedFile:0x00007fce91a39b68 @tempfile=#<Tempfile:/var/folders/k4/94s97qt50mz57yht9lwvcknh0000gn/T/RackMultipart20191115-54644-14agj2s.png>, @original_filename="download.png", @content_type="image/png", @headers="Content-Disposition: form-data; name=\"cocktail[photo]\"; filename=\"download.png\"\r\nContent-Type: image/png\r\n">, "photo_cache"=>""}, "commit"=>"Create Cocktail"}
  # another option is to do it on the front end
  # this is also better becasue with a defualt photo
  # I fill my db with shit I don't need.


  # private

  # def default_photo
  #   # self.photo = 'gmewp8rcecg7fqakys96' if self.photo.nil?
  # end
end


# SETTING DEFAULTS

# boolean
# you can do that in the migration

# but default photo
# you should do on the model
# so you can edit it
# (but actually not!)
# because there is no point filling your db
# with images which are not relevant when you can
# just load one on the front end
