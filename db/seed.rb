##
# This file contains some sample of data to add
# to the database
##

def pict_read(rel_path)
  File.open(File.dirname(__FILE__) + "/" + rel_path)
end

Location.create!(
  :picture => pict_read("images/laplage.png"),
  :name => "La Plage Digitale",
  :description => "Coworking space",
  :city => "Strasbourg",
  :country => "France",
  :is_real => true
)

Location.create!(
  :picture => pict_read("images/sanfrancisco.png"),
  :name => "San Francisco",
  :description => "US West Coast city, California",
  :city => "San Francisco",
  :country => "United States",
  :is_real => true
)

Location.create!(
  :picture => pict_read("images/bletchleypark.png"),
  :name => "Bletchley Park",
  :description => "Alan Turing home during WWII",
  :city => "Bletchley",
  :country => "United Kingdom",
  :is_real => true
)

Location.create!(
  :picture => pict_read("images/eiffeltower.png"),
  :name => "The Eiffel Tower",
  :description => "Famous building from the world expo of 1900 in Paris",
  :city => "Paris",
  :country => "France",
  :is_real => true
)

Location.create!(
  :picture => pict_read("images/atlantis.png"),
  :name => "Atlantis",
  :description => "The disappeared underwater city",
  :city => "Thessaloniki",
  :country => "Greece",
  :is_real => false
)

Location.create!(
  :picture => pict_read("images/ankhmorpork.png"),
  :name => "Ankh Morpork",
  :description => "Fictional city of the discworld from Terry Pratchett",
  :city => "Beaconsfield",
  :country => "United Kingdom",
  :is_real => false
)

Location.create!(
  :picture => pict_read("images/tautavel.png"),
  :name => "Tautavel Cave",
  :description => "Tautavel cave is a archeological research area in the South of France",
  :city => "Tautavel",
  :country => "France",
  :is_real => true
)

Location.create!(
  :picture => pict_read("images/cranfield.png"),
  :name => "Cranfield University",
  :description => "Does it need a description?",
  :city => "Cranfield",
  :country => "United Kingdom",
  :is_real => true
)

Location.create!(
  :picture => pict_read("images/guiness.png"),
  :name => "Guiness Brewery",
  :description => "Official Brewery of the beer Guiness",
  :city => "Dublin",
  :country => "Ireland",
  :is_real => true
)

Location.create!(
  :picture => pict_read("images/sagrada.png"),
  :name => "Sagrada Familia Cathedral",
  :description => "Eternal unfinished cathedral",
  :city => "Barcelona",
  :country => "Spain",
  :is_real => true
)
