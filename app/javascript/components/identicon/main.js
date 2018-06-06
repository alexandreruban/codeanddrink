const get_identicon = function(text) {
    const salt = "0";
    const rounds = "1";
    const size = 20;
    const outputType = "HEX";
    const hashtype = "SHA-512";
    const shaObj = new jsSHA(text+salt, "TEXT");
    const hash = shaObj.getHash(hashtype, outputType,rounds);
    const data = new Identicon(hash, size);
    return 'data:image/png;base64,' + data;
}
window.get_identicon = get_identicon

const set_img_src = function(id, src) {
  const img = document.getElementById(id);
  if (img) {
    img.src=src
  }
}
window.set_img_src = set_img_src
