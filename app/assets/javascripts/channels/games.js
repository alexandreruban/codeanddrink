//= require action_cable
//= require_self
//= require_tree .

console.log("Je suis dans games.js");

this.App = {};

App.cable = ActionCable.createConsumer();

App.games = App.cable.subscriptions.create('GamesChannel', {
  received: (data) => {
    console.log(data);
  }
});
