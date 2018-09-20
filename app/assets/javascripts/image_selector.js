function imageSelect() {
  var input = document.getElementById('artwork-input');
  var span = document.getElementById('selected-artwork');
  if (!input) {return};
  input.addEventListener('change', function(e) {
    if (!input.files[0]) {
      span.innerHTML = "No image selected";
      return;
    }
    var currentName = input.files[0].name;
    if (currentName) {
      span.innerHTML = currentName + " " + "<i class='fas fa-check'></i>"
    }
  })
}
document.addEventListener('turbolinks:load', imageSelect)
