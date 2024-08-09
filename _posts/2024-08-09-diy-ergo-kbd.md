---
layout: post
title: "The deep rabbit hole of DIY small ergonomic keyboards"
author: "Alexej Gossmann"
tags: [electronics, software]
---

![Reviung keyboard variants]({{ "/assets/img/2024-08-09-diy-ergo-kbd/reviungs.jpg" | absolute_url }})

The following poem, created using **Google Gemini** AI :robot:, chronicles my journey into the world of ergonomic DIY keyboards.
It documents my (evolving) preferences and opinions, as well as a curated list of resources that I have found useful over the last three years.

:keyboard: *Warning* :keyboard: The following verses are likely entirely incomprehensible for normal people, and could be interpreted as a sign of my descent into madness. :scream:
So, I guess, the main purpose of this is to serve as a time capsule for my future self. :shrug:


<style>
.poem {
    max-width: 800px;
    margin: 0 auto;
    background-color: #fff;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
}
.poem p {
  font-family: "Courier New", monospace;  /* Or choose a different monospace font */
  font-size: 1.1em;          /* Adjust font size as desired */
  line-height: 1.8;         /* Increase line spacing for better readability */
  text-align: center;       /* Center align the poem */
  margin-bottom: 30px;     /* Add space between stanzas */
  transition: transform 0.3s ease;
}
.poem p:hover {
    transform: scale(1.02);
}
.poem a {
    color: #4a4a4a;
    text-decoration: none;
    border-bottom: 1px dashed #4a4a4a;
    transition: color 0.3s ease, border-bottom 0.3s ease;
}
.poem a:hover {
    color: #007bff;
    border-bottom: 1px solid #007bff;
}
.poem figure {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 40px 0;
}
.poem-image, .poem-image-full {
    width: 100%;
    display: flex;
    justify-content: center;
}
/* .poem-image {
    text-align: center;
    margin-top: 40px;
} */
.poem-image img {
    max-width: 50%;
    height: auto;
    border-radius: 5px;
    box-shadow: 0 0 15px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
}
.poem-image img:hover {
    transform: scale(1.05);
}
/* .poem-image-full {
    text-align: center;
    margin-top: 40px;
} */
.poem-image-full img {
    max-width: 100%;
    height: auto;
    border-radius: 5px;
    box-shadow: 0 0 15px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
}
.poem-image-full img:hover {
    transform: scale(1.02);
}
.poem-image-caption {
    font-style: italic;
    font-size: 0.9em;
    color: #666;
    margin-top: 10px;
    text-align: center;
}
/* figcaption { font-style: italic; text-align: center; color: #666; margin-top: 10px; } */
@media (max-width: 600px) {
    .poem {
        padding: 20px;
    }
    .poem p {
        font-size: 1em;
    }
    .poem-image img,
    .poem-image-full img  {
        max-width: 100%;
    }
}
</style>


<article class="poem">
  <p>
    Clackety-thock goes the symphony,<br>
    My fingers dance on keycaps, wild and free.<br>
    Wrist aches whisper, thumbs start to cry,<br>
    But <a href="https://github.com/qmk/qmk_firmware">QMK</a> and <a href="https://github.com/zmkfirmware/zmk">ZMK</a>, my coding lullaby.
  </p>

  <p>
    No blueprints of my own, I'll openly declare,<br>
    <a href="https://golem.hu/board/list/open-source">Open source</a> is my love, a passion I readily share.<br>
    From <a href="https://github.com/foostan/crkbd">forty-two</a> keys to <a href="https://github.com/davidphilipbarr/Sweep">thirty-four</a>, I roam,<br>
    Ergonomics my mantra, soldering my ohm.
  </p>

  <p>
    Though productivity's my aim, it's a clever disguise,<br>
    For distraction's the siren, with each soldered wire's ties.<br>
    <a href="https://github.com/manna-harbour/miryoku">Miryoku</a>'s magic, dual functions divine,<br>
    (<a href="https://precondition.github.io/home-row-mods">Secrets unveiled, just click on these lines!</a>)
  </p>

  <p>
    <a href="https://en.wikipedia.org/wiki/Colemak">Colemak</a>'s my layout, a personalized twist,<br>
    With <a href="https://zmk.dev/docs/behaviors/sticky-key">one-shot shift</a>, number layer, nav's quick kiss.<br>
    But Backspace, the wanderer, roams with a whim,<br>
    While Enter, Tab, and Esc are lost on a limb.
  </p>

  <p>
    Thumb pain be banished, a firmware's embrace,<br>
    <a href="https://docs.qmk.fm/#/one_shot_keys">One-shot keys</a> take flight, a swift, thumb-saving chase.<br>
    (<a href="https://getreuer.info/posts/keyboards/thumb-ergo/index.html">Pascal's insights</a>, a guiding star's grace,)<br>
    No more held keys, just a gentle tap's space.
  </p>

  <p>
    <a href="https://docs.qmk.fm/features/dynamic_macros">Dynamic macros</a>, QMK's gift so grand,<br>
    Repetitive tasks vanish, like castles in sand.<br>
    <a href="https://zmk.dev/docs/behaviors/key-repeat">Repeat key</a>'s rhythm, <a href="https://docs.qmk.fm/features/combo">combos</a> untold,<br>
    Misfires banished, a legend of old.
  </p>

  <p>
    <a href="https://zmk.dev/docs/behaviors/macros">Macros</a> at the ready, each keystroke's delight,<br>
    My keymap's a symphony, shining so bright.<br>
    (But heed this warning, before you explore,)<br>
    (<a href="https://github.com/agisga/zmk-config">This snapshot</a>'s outdated, there's always more.)
  </p>

  <p>
    3D prints and soldering, a tinkerer's glee,<br>
    Feather-light switches, a soft melody.<br>
    Or weighty and firm, a thocky address,<br>
    With <a href="https://www.reddit.com/r/ErgoMechKeyboards/">key-loving comrades</a>, fueling this clacking success.
  </p>

  <figure>
    <div class="poem-image">
      <img src="/assets/img/2024-08-09-diy-ergo-kbd/minidox.jpg" alt="Minidox" title="Minidox">
    </div>
    <figcaption class="poem-image-caption">Toy sheep used for <a href="http://xahlee.info/kbd/keyboard_forearm_pronation.html">keyboard tenting</a>.</figcaption>
  </figure>

  <figure>
    <div class="poem-image-full">
      <img src="/assets/img/2024-08-09-diy-ergo-kbd/20220925-1month-monkeytype-excalidraw-export.png" alt="1 month colemak progress" title="Colemak">
    </div>
    <figcaption class="poem-image-caption">My first month with the Colemak keyboard layout: ~One-month typing speed progression: Transitioning from <a href="https://en.wikipedia.org/wiki/QWERTY">QWERTY</a> to <a href="https://en.wikipedia.org/wiki/Colemak">Colemak</a>, with a brief week using the <a href="https://forum.colemak.com/topic/1858-learn-colemak-in-steps-with-the-tarmak-layouts/">"Tarmak"</a> intermediate layouts.</figcaption>
  </figure>
</article>

