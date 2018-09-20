document.addEventListener('turbolinks:load', function() {
  if (!$('#text-edit')) {return};
  $('#text-edit').froalaEditor({
      heightMin: 250
  });
})
