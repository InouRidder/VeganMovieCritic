//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .


// initialize with defaults
$("#input-id").rating();

// with plugin options
$("#input-id").rating({min:1, max:10, step:2, size:'lg'});
