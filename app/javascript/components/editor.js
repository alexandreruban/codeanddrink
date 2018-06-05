import "ace-builds";
import "ace-builds/webpack-resolver";

function codescreen() {
  if (document.getElementById('editor')) {
    const editor = ace.edit("editor");
    editor.setTheme('ace/theme/monokai');
    editor.session.setMode("ace/mode/ruby");
    editor.commands.addCommand({
      name: 'myCommand',
      bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
      exec: function(editor) {
          // NOP
        },
      readOnly: true // false if this command should not apply in readOnly mode
    });

    const game =  document.getElementById("game");
    const form = document.getElementById("new_attempt");
    const input = document.getElementById("attempt_player_input");
    const inputPlayer = document.getElementById("player_id");
    const submit = document.getElementById("submit");
    const reset = document.getElementById("reset");
    const template = document.getElementById("template");
    const last_template = document.getElementById("last_attempt");
    if (submit) {
      submit.addEventListener('click', (event) => {
        event.preventDefault();
        input.value = editor.getValue();
        inputPlayer.value = game.dataset.currentPlayer;
        form.submit();
      });
    }
    if (reset) {
      reset.addEventListener('click', (event) => {
        event.preventDefault();
        editor.setValue(template.innerHTML);
      });
    }
    if (last_attempt.innerHTML == "") {
      editor.setValue(template.innerText);
    } else {
      editor.setValue(last_attempt.innerText);
    }
  }
}

export {codescreen};
