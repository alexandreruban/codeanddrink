import "bootstrap";
import { codescreen  } from '../components/editor';
import { finalscreens  } from '../components/final';

window.codescreen = codescreen;
codescreen();

window.finalscreens = finalscreens;
finalscreens();

renderAllIdenticons();
