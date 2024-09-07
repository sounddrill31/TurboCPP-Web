var DOSWASMSETTINGS = {
    CLOUDSAVEURL: "",
    ISOURL: "https://azcyouth.in/extra-cdn/images/tcpp-wasmx/testing/output.iso",
    DEFAULTIMG: ""
}

var rando = Math.floor(Math.random() * Math.floor(100000));
var script = document.createElement('script');
script.src = 'script.js?v=' + rando;
document.getElementsByTagName('head')[0].appendChild(script);
