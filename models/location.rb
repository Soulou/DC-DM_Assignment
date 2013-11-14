class String
  def to_sparqlparam
    self.split(" ").join("_")
  end
end

class Location
  include Mongoid::Document
  include Mongoid::Paperclip

  # Use gem mongoid-paperclip (which uses paperclip itself)
  # Add a picture attribute and manage two style for this picture
  has_mongoid_attached_file(
    :picture,
    :path => "public/img/:attachment/:id/:style/:basename.:extension",
    :styles => {
      :original => ['1920x1680>', :png],
      :thumb    => ['64x64>',   :png]
    }
  )

  field :name, :type => String
  field :description, :type => String
  field :city, :type => String
  field :country, :type => String
  field :is_real, :type => Boolean
  field :latitude, :type => Float
  field :longitude, :type => Float

  validates_presence_of :name, :city, :country
  validates_uniqueness_of :name

  def to_s
    "ID:'#{id}' #{name} @ #{city} (#{country})"
  end

  after_validation do |location|
    sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
    results = sparql.query %{
      PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>
      SELECT ?city ?country ?lat ?long WHERE {
      ?city geo:lat ?lat.
      ?city geo:long ?long.
      ?city dbpedia-owl:country ?country.
      ?city rdf:type ?type.
      FILTER(regex(?city, '/#{location.city.to_sparqlparam}$') && regex(?country, '#{location.country.to_sparqlparam}') && regex(?type, 'PopulatedPlace')).
      } LIMIT 1
    }
    if results.bindings.has_key? :long
      location.longitude = results.bindings[:long][0].value.to_f
    end
    if results.bindings.has_key? :lat
      location.latitude = results.bindings[:lat][0].value.to_f
    end
    if location.longitude.nil? && location.latitude.nil?
      puts "\e[1mNo geospacial coordinate for #{location}\e[0m"
    end
  end

  ### Mongoid corresponsances
  ## public List<Location> getAll();
  # Location.all
  #
  ## public List<Location> findByName(String name);
  ## (SQL: LIKE 'name%', but more powerful as regexp)
  # Location.where :name => /^name/
  #
  ## public Location getById(int id);
  # Location.find id
  #
  ## public Location create(Location location);
  # location.save/create
  #
  ## public Location update(Location location);
  # location.update_attributes
  #
  ## public boolean delete(Location location);
  # location.destroy
end
