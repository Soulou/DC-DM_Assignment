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

  validates_presence_of :name, :city, :country
  validates_uniqueness_of :name

  def to_s
    "ID:'#{id}' #{name} @ #{city} (#{country})"
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
