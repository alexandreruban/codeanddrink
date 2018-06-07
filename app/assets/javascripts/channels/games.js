//= require action_cable
//= require_self
//= require_tree .

let gameId = undefined;
let playerId = undefined;
let gameMasterId = undefined;
const gameContainer = document.getElementById("game");
if (gameContainer != null) {
  gameId = gameContainer.dataset.currentGame;
  playerId = gameContainer.dataset.currentPlayer;
  gameMasterId = gameContainer.dataset.currentGameMaster;
}
console.log("GameId:" + gameId)
console.log("playerId:" + playerId)
console.log("gameMasterId:" + gameMasterId)

if ((gameId != undefined) || (playerId != undefined) || (gameMasterId != null)) {

  this.App = {};

  App.cable = ActionCable.createConsumer();

  App.games = App.cable.subscriptions.create(
    { channel: 'GamesChannel', game_id: gameId, player_id: playerId, game_master_id: gameMasterId },
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
      } else if (data.message === "update players") {
        onUpdatePlayers(data);
      }
    }
  });
}

function onUpdatePlayers(data) {
  const playersContainer = document.getElementById("game-players");
  if (playersContainer) {
    playersContainer.innerHTML = data.players_partial
    renderAllIdenticons();
  }
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
  // const editor = document.getElementById("editor");
  // if (editor) {
  //   const content = document.querySelector(".ace_content");
  //   const headToken = document.head.querySelector("[name=csrf-token]").content;
  //   editor.addEventListener('keyup', function(event) {
  //     const url = window.location.href + "/content";
  //     fetch(url, {
  //       method: "POST",
  //       headers: {
  //         "Content-Type": "application/json",
  //         'X-CSRF-Token': headToken
  //       },
  //       credentials: 'same-origin',
  //       body: JSON.stringify({ content: content.innerText })
  //     });
  //   });
  // }
}

function onNewFinalContent(data) {
    const editor = document.getElementById("editor-" + data.player_id);
    if (editor) {
      aceEditor = ace.edit(editor);
      aceEditor.setValue(data.content);
      aceEditor.clearSelection();
    }
}
