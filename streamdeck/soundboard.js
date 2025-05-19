const allSounds = [
    document.getElementById("vine-boom"),
    document.getElementById("tuco-get-out"),
    document.getElementById("bakwe-the-hel-wak"),
    document.getElementById("wait-wait-wait-wait-wait-what-the-helllllll"),
    document.getElementById("sad"),
    document.getElementById("brain-fart"),
    document.getElementById("mimimimir"),
    document.getElementById("kokop"),
    document.getElementById("jawa100x"),
    document.getElementById("kobo-jawa"),
    document.getElementById("cihuyy-wielino"),
    document.getElementById("cat-laugh"),
    document.getElementById("backsound2"),
    document.getElementById("-9999-social-credit"),
    document.getElementById("bone-crack"),
    document.getElementById("extremely-loud-incorrect-buzzer_0cDaG20"),
    document.getElementById("flashbanggg"),
    document.getElementById("hidup-joko"),
    document.getElementById("lobotomy-sound-effect"),
    document.getElementById("long-brain-fart"),
    document.getElementById("pipe"),
    document.getElementById("prowler-sound-effect_6bXErot"),
    document.getElementById("sad-violin"),
    document.getElementById("triggered-video-effect-green-screen-with-sound"),
    document.getElementById("naber")
];

window.addEventListener("keydown", function(event) {
    const customsnd = document.getElementById('customsnd');

    allSounds.forEach(function(currentSound) {
        if (currentSound && !currentSound.paused) {
            currentSound.pause();
            currentSound.currentTime = 0;
        }
    });
    if (event.key === 'Enter' && customsnd.style.display === "block"){
        addsound()
    }
    else if (event.code === 'Numpad1') {
        let sound = allSounds[0];
        sound.play();
    }
    else if (event.code === 'Numpad2') {
        let sound = allSounds[4];
        sound.play()
    }
    else if (event.code === 'Numpad3') {
        let sound = allSounds[11];
        sound.play()
    }
})

const name = ["SUS",
            "Get Out",
            "BWTHW",
            "WAIT7 WTH",
            "SAD",
            "Brain Fart",
            "Mimimimir",
            "kokop",
            "jawa100x",
            "djawa100x",
            "cihuy",
            "cat laugh",
            "hvm Sound"
        ]

function Memesound(alok) {
    // Semua elemen suara yang ada
    

    // Hentikan semua suara yang sedang diputar
    allSounds.forEach(function(currentSound) {
        if (currentSound && !currentSound.paused) {
            currentSound.pause();
            currentSound.currentTime = 0;
        }
    });

    // Tentukan suara yang akan diputar berdasarkan nilai `alok`
    let sound = allSounds[alok];

    // Putar suara yang dipilih
    if (sound) {
        sound.play();
    }
}
function stopSound() {
    // Semua elemen suara yang ada
    
    allSounds.forEach(function(currentSound) {
        if (currentSound && !currentSound.paused) {
            currentSound.pause();
            currentSound.currentTime = 0;
        }
    });
}

function addsound(){
    let input = document.getElementById('inputsnd').value
    let list = document.getElementById('soundbutton')
    const addsound = document.createElement('div')
    addsound.innerHTML = `<button onclick="Memesound(${input})" class = "custom">${name[input]}</button>`
    
    list.appendChild(addsound)
    document.getElementById('inputsnd').value = ""
    addsound.querySelector('.del').addEventListener("contextmenu", () => addsound.classList.toggle = "del");
}

function deletesnd() {
    document.querySelectorAll('.del').forEach(el => el.remove())
}
function clsnd() {
    const listsounds = document.getElementById('listsounds')
    const customsnd = document.getElementById('customsnd')

    listsounds.style.display = 'none'
    customsnd.style.display = 'block'
}

function back() {
    const listsounds = document.getElementById('listsounds')
    const customsnd = document.getElementById('customsnd')

    listsounds.style.display = 'block'
    customsnd.style.display = 'none'
}