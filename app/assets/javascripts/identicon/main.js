const getIdenticon = function(text) {
    const salt = "0";
    const rounds = "1";
    const size = 220;
    const outputType = "HEX";
    const hashtype = "SHA-512";
    const shaObj = new jsSHA(text+salt, "TEXT");
    const hash = shaObj.getHash(hashtype, outputType,rounds);
    const data = new Identicon(hash, size);
    return 'data:image/png;base64,' + data;
}

const setImgSrc = function(id, src) {
  const img = document.getElementById(id);
  if (img) {
    img.src=src
  }
}

const renderAllIdenticons = function() {
  const images = document.querySelectorAll(".avatar img");
  for (i = 0; i < images.length; ++i) {
    const image = images[i];
    setImgSrc(image.id, getIdenticon(image.id));
  }
}
