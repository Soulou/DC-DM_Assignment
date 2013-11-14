mapInit = ->
  @markers = []
  mapOptions =
    center: new google.maps.LatLng(52.073703,-0.627106)
    minZoom: 1
    maxZoom: 10
    zoom: 10
    mapTypeId: google.maps.MapTypeId.ROADMAP
  @map = new google.maps.Map document.getElementById("locations_map"), mapOptions

mapClearMarker = ->
  _.each @markers, (marker) ->
    marker.setMap(null)
  @markers = []

mapAddMarker = (name, long, lat) ->
  pos = new google.maps.LatLng lat, long
  marker = new google.maps.Marker
    position: pos
    map: @map
    title: name
  @markers.push marker

  if @markers.length == 1
    @map.setCenter @markers[0].getPosition()
    @map.setZoom 10
  else
    bounds = new google.maps.LatLngBounds()
    _.each @markers, (marker) ->
      bounds.extend marker.getPosition()
    map.fitBounds bounds

$ ->
  $("#locations_form").on "submit", (event) ->
    event.preventDefault()
    false

  $("#location_name").on "keyup", (event) ->
    # We remove the privous markers
    mapClearMarker()

    if this.value == ""
      $("#locations_lists").html ""
      return

    url = "/locations/search/" + escape(this.value)
    # AJAX Request
    $.get url, (data, status, xhr) ->
      # Refresh the locations list
      $("#locations_lists").html(
        _.map(data, (c) ->
          "<li class=\"location\">" + c.name + "<br>" + c.city + " " + c.country + "</li>"
        ).join("")
      )
      _.map data, (c) ->
        # Add marker of each place on the map
        if c.longitude && c.latitude
          mapAddMarker c.name, c.longitude, c.latitude
      

# Initialize google maps
google.maps.event.addDomListener window, 'load', mapInit
