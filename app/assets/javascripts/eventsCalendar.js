$(document).ready(function() {

  $('#eventsCalendar').fullCalendar({
    header: {
      left: 'title',
      center: '',
      right: 'month, basicWeek, basicDay, prev,next'
    },
    footer: {
      left: '',
      center: '',
      right: 'month, basicWeek, basicDay, prev,next'
    },
    events: '/events/get_events',
    eventColor: '#17245d',
    timeFormat: 'LT',
    eventClick: function(event) {
      if (event.url) {
        window.open(event.url, _self);
        return true;
      }
    }
  });
});
