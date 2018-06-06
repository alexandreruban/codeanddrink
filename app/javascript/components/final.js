function finalscreens() {

  const template = document.getElementById("template");

  let editorId0 = undefined;
  let editorId1 = undefined;
  const gameContainer = document.getElementById("game");
  if (gameContainer != null) {
    console.log(gameContainer.dataset);
    editorId0 = "editor-" + gameContainer.dataset.playerZero;
    editorId1 = "editor-" + gameContainer.dataset.playerOne;
  }

  console.log(editorId0);
  console.log(editorId1);

  const last_attempt_0 = document.getElementById("last-attempt-0");
  if (document.getElementById(editorId0)) {
    const editorPlayer0 = ace.edit(editorId0);
    editorPlayer0.setTheme('ace/theme/monokai');
    editorPlayer0.session.setMode("ace/mode/ruby");
    editorPlayer0.commands.addCommand({
      name: 'myCommand',
      bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
      exec: function(editor) {
          // NOP
        },
      readOnly: true // false if this command should not apply in readOnly mode
    });
    if (last_attempt_0.innerHTML == "") {
      editorPlayer0.setValue(template.innerText);
      editorPlayer0.clearSelection();
    } else {
      editorPlayer0.setValue(last_attempt_0.innerText);
    }
  }

  const last_attempt_1 = document.getElementById("last-attempt-1");
  if (document.getElementById(editorId1)) {
    const editorPlayer1 = ace.edit(editorId1);
    editorPlayer1.setTheme('ace/theme/monokai');
    editorPlayer1.session.setMode("ace/mode/ruby");
    editorPlayer1.commands.addCommand({
      name: 'myCommand',
      bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
      exec: function(editor) {
          // NOP
        },
      readOnly: true // false if this command should not apply in readOnly mode
    });
    if (last_attempt_1.innerHTML == "") {
      editorPlayer1.setValue(template.innerText);
      editorPlayer1.clearSelection();
    } else {
      editorPlayer1.setValue(last_attempt_1.innerText);
    }
  }

}

export {finalscreens};
