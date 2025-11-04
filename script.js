function playLive() {
    const player = document.getElementById('zeno-player');
    player.style.display = 'block';
    player.src = 'https://zeno.fm/radio/dream-podcast/embed';
    player.scrollIntoView({behavior: 'smooth'});
}
