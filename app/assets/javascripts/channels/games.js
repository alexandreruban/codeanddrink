//= require action_cable
//= require_self
//= require_tree .

let gameId = undefined;
let playerId = undefined;
const gameContainer = document.getElementById("game");
if (gameContainer != null) {
  gameId = gameContainer.dataset.currentGame;
  playerId = gameContainer.dataset.currentPlayer;
}
console.log("GameId:" + gameId)
console.log("playerId:" + playerId)

if ((gameId != undefined) || (playerId != undefined)) {

  this.App = {};

  App.cable = ActionCable.createConsumer();

  App.games = App.cable.subscriptions.create(
    { channel: 'GamesChannel', game_id: gameId, player_id: playerId },
    { received: (data) => {
      if (data.message === "round started") {
        onRoundStarted(data);
      } else if (data.message === "attempt") {
        onAttempt(data);
      } else if (data.message === "round stopped") {
        onRoundStopped(data);
      }
    }
  });
}

function onRoundStarted(data) {
  gameContainer.innerHTML = data.game_partial;
  window.codescreen();
}

function onAttempt(data) {
  const testsContainer = document.getElementById('tests');
  testsContainer.innerHTML = data.tests_partial;
}

function onRoundStopped(data) {
  gameContainer.innerHTML = data.ranking_partial;
}
