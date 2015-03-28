function resizeContent() {
    $height = $(window).height();
    $('body .banner').height($height-48);
    $('body .more_info').height($height);
    $('body .banner_overlay').css("top",($height/4));
}

function setRandomBackgroundImage(){
	var images = 8;
	var number = Math.floor(Math.random(1) * images) + 1;
	var link = "url(/static/app/content/frontpage/image" + number + ".jpg)"; 
	$( '#top' ).css("background-image",link);
}

$(document).ready(function(){
    resizeContent();
    setRandomBackgroundImage();

    $(window).resize(function() {
        resizeContent();
    });

    $('a[href^="#"]').on('click',function (e) {
	    e.preventDefault();

	    var target = this.hash;
	    var $target = $(target);

	    $('html, body').stop().animate({
	        'scrollTop': $target.offset().top
	    }, 900, 'swing', function () {
	        window.location.hash = target;
	    });
	});
	$('body').on({
		'mousewheel': function(e) {
    	if (e.target.id == 'el') return;
    	e.preventDefault();
    	e.stopPropagation();
    }
})
});