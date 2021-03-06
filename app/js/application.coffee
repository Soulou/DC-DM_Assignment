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

  @previous = ""
  $("#location_name").on "keyup", (event) ->
    if this.value == @previous
      return

    # We remove the privous markers
    mapClearMarker()

    if this.value == "" || this.value == "."
      $("#locations_lists").html ""
      return

    url = "/locations/search/" + escape(this.value)
    @previous = this.value
    # AJAX Request
    $.ajax
      type: "GET"
      url: url
      beforeSend: (xhr, settings) ->
        $("#pacman").toggleClass("invisible")
      success: (data, status, xhr) ->
        $("#pacman").toggleClass("invisible")
        # Refresh the locations list
        if data.length == 0
          $("#locations_lists").html(
              "<li class=\"location\"><p>No place found</p></li>"
          )
          return

        $("#locations_lists").html(
          _.map(data, (c) ->
            text = ""
            if c.description
              text +="<li class=\"location\" data-toggle=\"tooltip\" title=\""+c.description+"\">"
            else
              text +="<li class=\"location\">"

            if !c.picture.thumb.url.match /missing\.png/
              text += "<i class=\"glyphicon glyphicon-camera\" />"
              text += "<a href=\""+c.picture.original.url+"\"><img alt=\""+c.name+"\" src=\""+c.picture.thumb.url+"\"></a>"

            text += "<p>" + c.name + "<br>" + c.city + " " + c.country + "</p></li>"
            return text
          ).join("")
        )
        _.map data, (c) ->
          # Add marker of each place on the map
          if c.longitude && c.latitude
            mapAddMarker c.name, c.longitude, c.latitude
      

# Initialize google maps
google.maps.event.addDomListener window, 'load', mapInit
