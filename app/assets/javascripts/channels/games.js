//= require action_cable
//= require_self
//= require_tree .

console.log("Je suis dans games.js");

const gameContainer = document.getElementById("game");
if (gameContainer) {

  const playerId = gameContainer.dataset.currentPlayer;
  console.log(playerId);

  this.App = {};

  App.cable = ActionCable.createConsumer();

  App.games = App.cable.subscriptions.create(
    { channel: 'GamesChannel', player_id: playerId },
    { received: (data) => {
      console.log(data);
      const testsContainer = document.getElementById('tests');
      testsContainer.innerHTML = data.tests_partial;
    }
  });
}

