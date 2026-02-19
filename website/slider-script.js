document.addEventListener('DOMContentLoaded', function() {
    var img = document.getElementById('img');
    var slides = ['cricket-slider.webp', 'basketball-slider.webp', 'football-slider.jpeg'];
    var start = 0;

    function slider() {
        if (start < slides.length - 1) {
            start += 1;
        } else {
            start = 0;
        }
        img.classList.add('fade-in');
        setTimeout(function() {
            document.getElementById('img').innerHTML = "<img src=" +slides[start]+">";
            img.classList.remove('fade-in');
        }, 1500 );
    }

    setInterval(slider, 3000);
});