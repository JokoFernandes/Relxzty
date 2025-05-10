function replaceTextWithEmojis(node) {
    if (node.nodeType === 3) { // 3 = Node teks
        let emojiMap = {
            ":01:": "<img src='https://static.wikia.nocookie.net/roblox-blox-piece/images/c/c3/KitsuneFruit.png/revision/latest?cb=20241223162956' alt='' class='emoticon'>",
            ":Cchill:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/c/cd/Icon_Emoji_Paimon%27s_Paintings_33_Clorinde_3.png/revision/latest?cb=20240614144526' alt='' class='emoticon'>",
            ":minecraft:": "<img src='https://img.tapimg.net/market/images/12f0150a5c552dcb052587d1c5a26dd2.png' alt='' class='emoticon'>",
            ":correct:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/f/f2/Icon_Emoji_Paimon%27s_Paintings_05_Hu_Tao_6.png/revision/latest?cb=20240303110342' alt='' class='emoticon'>",
            ":search:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/1/18/Icon_Emoji_Paimon%27s_Paintings_05_Hu_Tao_2.png/revision/latest?cb=20240303105947' alt='' class='emoticon'>",
            ":Thanks:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/a/ae/Icon_Emoji_Paimon%27s_Paintings_21_Hu_Tao_1.png/revision/latest?cb=20230120042714' alt='' class='emoticon'>",
            ":cool:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/2/2c/Icon_Emoji_Paimon%27s_Paintings_29_Navia_2.png/revision/latest?cb=20231228162411' alt='' class='emoticon'>",
            ":takemoney:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/b/b1/Icon_Emoji_Paimon%27s_Paintings_38_Hu_Tao_1.png/revision/latest?cb=20250128140331' alt='' class='emoticon'>",
            ":check:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/0/03/Icon_Emoji_Paimon%27s_Paintings_26_Navia_1.png/revision/latest?cb=20230824043600' alt='' class='emoticon'>",
            ":primo:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/d/d4/Item_Primogem.png/revision/latest?cb=20201117071158' alt='' class='emoticon'>",
            ":gift:": "<img src='https://static.wikia.nocookie.net/gensin-impact/images/4/45/Item_Windblume_Gift.png/revision/latest?cb=20230303160934' alt='' class='emoticon'>",
            ":yt:": "<img src='assets/emoji/youcube.png' alt='' class='emoticon' width='100' height='100'>",
            ":tt:": "<img src='assets/emoji/tiktok.png' alt='' class='emoticon' width='100' height='100'>",
            ":ig:": "<img src='assets/emoji/ig.png' alt='' class='emoticon'>",
            ":scbz:": "<img src='assets/emoji/sociabuzz.png' alt='' class='emoticon'>",
            ":dc:": "<img src='assets/emoji/discord.png' alt='' class='emoticon' style='border-radius:4px;'>",
            ":saweria:": "<img src='https://saweria.co/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fcapy_happy.603c7293.svg&w=384&q=75' alt='' class ='emoticon'>"
        };

        let text = node.nodeValue;
        for (let key in emojiMap) {
            let regex = new RegExp(key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), "g");
            text = text.replace(regex, emojiMap[key]);
        }

        let span = document.createElement("span");
        span.innerHTML = text;
        node.replaceWith(span);
    } else {
        node.childNodes.forEach(replaceTextWithEmojis);
    }
}

document.addEventListener("DOMContentLoaded", function() {
    replaceTextWithEmojis(document.body);
});
