class Cocktail < ApplicationRecord
  # before_create :default_photo
  # this is meant to work before .save too, but not sure

  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, uniqueness: true, presence: true
  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader


  # so I was thinking of having a private method
  # to set a defalt photo, but firstly a photo is complex
  # not 'gmewp8rcecg7fqakys96'
  # it is
  # "photo"=>#<ActionDispatch::Http::UploadedFile:0x00007fce91a39b68 @tempfile=#<Tempfile:/var/folders/k4/94s97qt50mz57yht9lwvcknh0000gn/T/RackMultipart20191115-54644-14agj2s.png>, @original_filename="download.png", @content_type="image/png", @headers="Content-Disposition: form-data; name=\"cocktail[photo]\"; filename=\"download.png\"\r\nContent-Type: image/png\r\n">, "photo_cache"=>""}, "commit"=>"Create Cocktail"}
  # another option is to do it on the front end
  # this is also better becasue with a defualt photo
  # I fill my db with shit I don't need.


  # see seeds... for File.new()

  # private

  # def default_photo
  #   # self.photo = 'gmewp8rcecg7fqakys96' if self.photo.nil?
  # end
end
