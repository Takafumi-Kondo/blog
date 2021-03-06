// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require chartkick
//= require Chart.bundle

$(document).ready(function(){
// slick
	$('.top_contents').slick({
		autoplay: true,
		autoplaySpeed: 3000,
		arrows: false,
		dots: true,
		centerMode: true,
		variableWidth: true,//スライド幅を可変にするか
	});
// jscroll
	$('.jscroll').jscroll({
		contentSelector: '.jscroll',//読み込む要素指定
		nextSelector: 'span.next:last a'//次ページ指定 next:lastで最後のリンクのみを読み込むようにしている。
	});
// クリックでトップページへ
	$('.toppage').click(function() {
		$("html,body").animate({scrollTop:0}, "normal");//scrollTop:0でウィンドウの一番上指定
	});

	$('.toppage').hide();
    $(window).scroll(function() {
        if($(window).scrollTop() > 0) {
            $('.toppage').slideDown(200);
        } else {
            $('.toppage').slideUp(200);
        }
    });
//フラッシュメッセ
    $(window).load(function() {
    	setTimeout("$('.alertfadeout').fadeOut()", 3000);
    });

    $('.hm_menu').on('click', function() {
    	$(this).toggleClass('active');
    	$('.header_nav').fadeToggle();
    	return false;
    });
});
