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
      console.log(data);
      if (data.message === "new player") {
        onNewPlayer(data);
      } else if (data.message === "round started") {
        onRoundStarted(data);
      } else if (data.message === "attempt") {
        onAttempt(data);
      } else if (data.message === "round stopped" || data.message === "successful attempt") {
        onRoundStopped(data);
      } else if (data.message === "new ranking") {
        onNewRanking(data);
      } else if (data.message === "final started") {
        onFinalStarted(data);
      } else if (data.message === "new final content") {
        onNewFinalContent(data);
      }
    }
  });
}

function onNewPlayer(data) {
  const playersContainer = document.getElementById('game-players');
  if (playersContainer) {
    playersContainer.innerHTML = data.players_partial;
    renderAllIdenticons();
  }
}

function onRoundStarted(data) {
  const gameFrame = document.getElementById("game-frame");
  gameFrame.innerHTML = data.game_partial;
  window.codescreen();
  renderAllIdenticons();
}

function onAttempt(data) {
  const testsContainer = document.getElementById('tests');
  if (testsContainer) {
    testsContainer.innerHTML = data.tests_partial;
    renderAllIdenticons();
  }
}

function onRoundStopped(data) {
  const gameFrame = document.getElementById("game-frame");
  gameFrame.innerHTML = data.ranking_partial;
  renderAllIdenticons();
}

function onNewRanking(data) {
  const ranking = document.getElementById("ranking");
  if (ranking) {
    ranking.innerHTML = data.new_ranking_partial;
    renderAllIdenticons();
  }
}

function onFinalStarted(data) {
  const editor = document.getElementById("editor");
  const content = document.querySelector(".ace_content");
  const headToken = document.head.querySelector("[name=csrf-token]").content;
  if (editor) {
    editor.addEventListener('keyup', function(event) {
      console.log(content.innerText);
      const url = "http://localhost:3000/games/" + gameId + "/players/" + playerId + "/content";
      console.log(url);
      fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": headToken
        },
        body: JSON.stringify({ content: content.innerText })
      });
    });
  }
}

function onNewFinalContent(data) {
    const editor = document.getElementById("editor-" + data.player_id);
    console.log(editor);
    if (editor) {
      const content = editor.querySelector(".ace_content");
      content.innerText = data.content;
    }
}
