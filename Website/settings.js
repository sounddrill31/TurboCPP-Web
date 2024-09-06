var DOSWASMSETTINGS = {
    CLOUDSAVEURL: "",
    ISOURL: "",
    DEFAULTIMG: "https://cdn.jsdelivr.net/sounddrill31/TurboCPP-Web@doswasmx/images/06092024/hdd1.img"
}

var rando = Math.floor(Math.random() * Math.floor(100000));
var script = document.createElement('script');
script.src = 'script.js?v=' + rando;
document.getElementsByTagName('head')[0].appendChild(script);