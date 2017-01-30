function createGmap(dataFromServer) {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: 'venue_map'}
    },
    function() {
      markers = handler.addMarkers(dataFromServer);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setZoom(12)
    }
  );
};

function loadAndCreateVenueGmap() {
  // Only load map data if we have a map on the page
  if ($('#venue_map').length > 0) {
    // Access the data-apartment-id attribute on the map element
    var venueId = $('#venue_map').attr('data-venue-id');

    $.ajax({
      dataType: 'json',
      url: '/venues/' + venueId + '/map_location',
      method: 'GET',
      success: function(dataFromServer) {
        // console.log(dataFromServer)
        createGmap(dataFromServer);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};


  // Create the map when the page loads the first time
  $(document).on('ready', loadAndCreateVenueGmap);
  // Create the map when the contents is loaded using turbolinks
  // To be 'turbolinks:load' in Rails 5
  // $(document).on('page:load', loadAndCreateVenueGmap);
