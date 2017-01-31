/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */

function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// // Close the dropdown menu if the user clicks outside of it
// window.onclick = function(event) {
//   if (!event.target.matches('.dropbtn')) {
//
//     var dropdowns = document.getElementsByClassName("dropdown-content");
//     var i;
//     for (i = 0; i < dropdowns.length; i++) {
//       var openDropdown = dropdowns[i];
//       if (openDropdown.classList.contains('show')) {
//         openDropdown.classList.remove('show');
//       }
//     }
//   }
// }


function createEventGmap(dataFromServer) {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: 'event_map'}
    },
    function() {
      markers = handler.addMarkers(dataFromServer);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setZoom(12)
    }
  );
};

function loadAndCreateEventGmap() {
  // Only load map data if we have a map on the page
  if ($('#event_map').length > 0) {
    // Access the data-apartment-id attribute on the map element
    var venueId = $('#event_map').attr('data-venue-id');
    // console.log($('#event_map').attr('data-venue-id'))

    $.ajax({
      dataType: 'json',
      url: '/venues/' + venueId + '/map_location',
      method: 'GET',
      success: function(dataFromServer) {
        // console.log(dataFromServer)
        createEventGmap(dataFromServer);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

// Create the map when the page loads the first time
  $(document).on('ready', loadAndCreateEventGmap);
  // Create the map when the contents is loaded using turbolinks
  // To be 'turbolinks:load' in Rails 5
  // $(document).on('page:load', loadAndCreateEventGmap);
