FlexSlider = function () {
    return {
        initSlider: function(){
            //Second item slider
            //jQuery(window).load(function() {
                jQuery('.flexSlideshow').flexslider({
                    animation: "fade",
                    controlNav: false,
                    directionNav: true ,
                    slideshowSpeed: 8000
                });
            //});

            //Portfolio item slider
            //jQuery(window).load(function() {
                jQuery('.flexportfolio').flexslider({
                    animation: "fade",
                    controlNav: false,
                    directionNav: true ,
                    slideshowSpeed: 8000
                });
            //});
        }
    }
}();