##
# This file contains some sample of data to add
# to the database
##

def pict_read(rel_path)
  File.open(File.dirname(__FILE__) + "/" + rel_path)
end

Location.create(
  :picture => pict_read("images/laplage.png"),
  :name => "La Plage Digitale",
  :descrption => "Coworking space",
  :city => "Strasbourg",
  :country => "France",
  :is_real => true
)

Location.create(
  :picture => pict_read("images/sanfrancisco.png"),
  :name => "San Francisco",
  :descrption => "US West Coast city, California",
  :city => "San Francisco",
  :country => "United States",
  :is_real => true
)

Location.create(
  :picture => pict_read("images/bletchleypark.png"),
  :name => "Bletchley Park",
  :descrption => "Alan Turing home during WWII",
  :city => "Bletchley",
  :country => "United Kingdom",
  :is_real => true
)

Location.create(
  :picture => pict_read("images/eiffeltower.png"),
  :name => "The Eiffel Tower",
  :descrption => "Famous building from the world expo of 1900 in Paris",
  :city => "Paris",
  :country => "France",
  :is_real => true
)

Location.create(
  :picture => pict_read("images/atlantis.png"),
  :name => "Atlantis",
  :descrption => "The disappeared underwater city",
  :city => "Athen",
  :country => "Greece",
  :is_real => false
)

Location.create(
  :picture => pict_read("images/ankhmorpork.png"),
  :name => "Ankh Morpork",
  :descrption => "Fictional city of the discworld from Terry Pratchett",
  :city => "Beaconsfield",
  :country => "United Kingdom",
  :is_real => false
)

Location.create(
  :picture => pict_read("images/tautavel.png"),
  :name => "Tautavel Cave",
  :descrption => "Tautavel cave is a archeological research area in the South of France",
  :city => "Tautavel",
  :country => "France",
  :is_real => true
)

Location.create(
  :picture => pict_read("images/cranfield.png"),
  :name => "Cranfield University",
  :descrption => "Does it need a description?",
  :city => "Cranfield",
  :country => "United Kingdom",
  :is_real => true
)

Location.create(
  :picture => pict_read("images/ankhmorpork.png"),
  :name => "Ankh Morpork",
  :descrption => "Fictional city of the discworld from Terry Pratchett",
  :city => "Beaconsfield",
  :country => "United Kingdom",
  :is_real => true
)
