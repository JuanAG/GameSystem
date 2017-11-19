// Para el login

$("#accountLoginLi").mouseenter( function () {
    $("#accountLoginLi").addClass("showLogin");
});

$("#loginbox").mouseleave( function () {

    if (!$("#mainLoginForm").is(":focus")) {
        $("#accountLoginLi").removeClass("showLogin");
    }

});