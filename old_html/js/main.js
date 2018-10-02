function osm(){ alert("osman abi?"); }
function err(msg){ alert(msg); }

var currentBox;

function slideDownBox (boxName){
    $(currentBox).parent(".actions").parent().find(".box_"+boxName).show();
}
function slideUpBox (boxName){
    $(currentBox).parent(".actions").parent().find(".box_"+boxName).hide();
}

$(document).ready(function () {
    
    $('.list-movies li').hover(
        function () { $(this).find(".actions").css("display", "block");}, 
        function () { $(this).find(".actions").css("display", "none");}
    );
    
    $('.add').click(function () { $(this).parent(".actions").siblings(".box_add").slideDown();});
    $('.wnt').click(function () { $(this).parent(".actions").siblings(".box_wnt").slideDown(); });
    $('.del').click(function () { $(this).parent(".actions").siblings(".box_del").slideDown(); });
    $('.bck_add').click(function () { $(this).parent(".box_add").slideUp();});
    $('.bck_wnt').click(function () { $(this).parent(".box_wnt").slideUp();});
    $('.bck_del').click(function () { $(this).parent(".box_del").slideUp();});
    
});
