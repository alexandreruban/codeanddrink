import "ace-builds";
import "ace-builds/webpack-resolver";

function codescreen() {
  const editor = ace.edit("editor");
  editor.setTheme('ace/theme/monokai');
  editor.session.setMode("ace/mode/ruby");

  const form = document.getElementById("new_attempt");
  const input = document.getElementById("attempt_player_input");
  const submit = document.getElementById("submit");
  if (submit) {
   submit.addEventListener('click', (event) => {
     event.preventDefault();
     input.value = editor.getValue();
     form.submit();
   });
 }
}
export {codescreen};
