attributes :name, :city, :country, :description, :is_real
node(:id) { |location| location.id.to_s }

node(:picture) do |location|
  Hash[location.picture.styles.map do |style_name, style|
    [style_name, {format: style.geometry, url: location.picture.url(style_name)}]
  end]
end

node(:links) do |location|
  { "self" => "http://#{request.env["HTTP_HOST"]}/locations/#{location.id}" }
end

