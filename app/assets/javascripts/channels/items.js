App.items = App.cable.subscriptions.create('ItemsChannel', {  
  received: function(data) {
    // Forces listening page to refresh after receiving data
    window.location.reload()
  }
});

