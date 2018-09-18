var listItemActivator = {
  initialize: function(){
    self = listItemActivator;
    self.listItems = document.querySelectorAll('.list-item');
    if (!self.listItems) {return};
    self.setListItemsListeners();
  },

  setListItemsListeners: function() {
    self.listItems.forEach(function(item){
      item.addEventListener('click', self.activateListItem)
    })
  },


  activateListItem: function(event) {
    self.desactivateListItems();
    event.currentTarget.classList.add('active')
  },

  desactivateListItems: function() {
    self.listItems.forEach(function(item) {
      item.classList.remove('active')
    })
  }

}


document.addEventListener('DOMContentLoaded', listItemActivator.initialize)
