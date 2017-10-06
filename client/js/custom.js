/* GESTIONE MAPS & SERCHER
 ============================================== */
var $filter = $('.filter');
var $maps   = $('#map-container');
var $search = $('#content-search');
var $searcher = $(".searcher");
var $position = parseInt($searcher.css('bottom'), 10);

function viewFullMaps() {
    $maps.toggleClass('full-screen');
}

$('.botton-options').on('click', function(){
    hideSearcher();
});

function hideSearcher(navigatorMap){

    if(navigatorMap==true){
        $searcher.slideUp(220);
    } else {
        $searcher.slideToggle(220);
    }
    return false;
}

$(".set-searcher").on('click', hideSearcher);

$(".more-button").on('click', function(){
    $filter.toggleClass('hide-filter');
    return false;
});