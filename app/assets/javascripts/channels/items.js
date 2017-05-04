App.items = App.cable.subscriptions.create('ItemsChannel', {  
  received: function(data) {
    $("#items").removeClass('hidden')
    return $('#items').append(this.renderItem(data));
  },

  renderItem: function(data) {
    return "<p> <b>" + data.done + ": </b>" + data.item + "</p>";
  }
});

