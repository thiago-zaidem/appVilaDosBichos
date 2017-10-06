MSfullWidth = function () {
    return {
        //Master Slider - Full Width
        initMSfullWidth: function () {
		    var slider = new MasterSlider();
            slider.control('arrows');
            slider.control('bullets' ,{autohide:false});
		    slider.setup('masterslider' , {
		        width:1024,
		        height:544,
		        fullwidth:true,
                centerControls:false,
		        speed:10,
		        view:'scaleFlow',
				loop:true,
                autoplay: true
            });
        },

        initMSfullDefault: function () {
            var slider = new MasterSlider();
            // slider controls
            //slider.control('arrows'     ,{ autohide:true, overVideo:true  });
            //slider.control('bullets'    ,{ autohide:true, overVideo:true, dir:'h', align:'bottom', space:6 , margin:10  });
            //slider.control('timebar'    ,{ autohide:false, overVideo:true, align:'bottom', color:'#FFFFFF'  , width:4 });

            // slider setup
            slider.setup('masterslider', {
                width           : 1024,
                height          : 597,
                minHeight       : 0,
                space           : 0,
                start           : 1,
                grabCursor      : true,
                swipe           : true,
                mouse           : true,
                keyboard        : false,
                layout          : "fullwidth",
                wheel           : false,
                autoplay        : true,
                instantStartLayers:true,
                loop            : true,
                shuffle         : false,
                preload         : 0,
                heightLimit     : true,
                autoHeight      : false,
                smoothHeight    : true,
                endPause        : false,
                overPause       : true,
                fillMode        : "fill",
                centerControls  : false,
                startOnAppear   : false,
                layersMode      : "center",
                autofillTarget  : "",
                hideLayers      : false,
                fullscreenMargin: 0,
                speed           : 6,
                dir             : "h",
                parallaxMode    : 'swipe',
                view            : "flow"
            });
        }
    };
}();