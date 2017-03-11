$(document).ready(function(){
  $( "*[id*=slider-range]:visible" ).each(function() {
    var slider_el = $(this);
    slider_el.parent().find( "#time-start" ).val(10);
    slider_el.parent().find( "#time-end" ).val(15);
    slider_el.slider({
      range: true,
      min: 0,
      max: 24,
      values: [ 10, 15 ],
      slide: function( event, ui ) {
        slider_el.parent().find( "#time-range" ).html(ui.values[ 0 ] + ":00 - " + ui.values[ 1 ] + ":00");
        slider_el.parent().find( "#time-start" ).val(ui.values[ 0 ]);
        slider_el.parent().find( "#time-end" ).val(ui.values[ 1 ]);
      }
    });
  });
  $( "*[id*=time-range]:visible" ).each(function() {
    $(this).html($(this).closest('div').find( "#slider-range" ).slider( "values", 0 ) + ":00 - " 
    + $(this).closest('div').find( "#slider-range" ).slider( "values", 1 ) + ":00");
  });
});