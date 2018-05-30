import "ace-builds";
import "ace-builds/webpack-resolver";

function codescreen() {
  var editor = ace.edit("editor");
  editor.setTheme('ace/theme/monokai');
  editor.session.setMode("ace/mode/ruby");
}
export {codescreen};
