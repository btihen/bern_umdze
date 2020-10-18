'use strict';

// https://siongui.github.io/2018/09/27/vuejs-bulma-modal/
// https://siongui.github.io/2018/02/11/bulma-modal-with-javascript/

document.addEventListener('DOMContentLoaded', function () {

  document.getElementById("newEventToggle").onclick = function () {
    var $target

    // open the new event card
    $target = document.getElementById("newEventContent");
    $target.setAttribute('class', 'card-content');

    // clear the previous event_id
    $target = document.getElementById("reservation_event_id")
    $target.selectedIndex = 0;

    // close the existing event card
    $target = document.getElementById("existingEventContent");
    $target.setAttribute('class', 'card-content is-hidden');

    // prevent form submission
    event.preventDefault();
  }

  document.getElementById("existingEventToggle").onclick = function () {
    var $target

    // open the existing event card
    $target = document.getElementById("existingEventContent");
    $target.setAttribute('class', 'card-content');

    // clear the form when closing
    $target = document.getElementById("reservation_event_name")
    $target.value = ''
    $target = document.getElementById("reservation_event_description")
    $target.value = ''

    // close the new event card
    $target = document.getElementById("newEventContent");
    $target.setAttribute('class', 'card-content is-hidden');

    // prevent form submission
    event.preventDefault();
  }

});
