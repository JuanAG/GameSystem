// Para el login

$("#accountLoginLi").mouseenter( function () {
    $("#accountLoginLi").addClass("muestraLogin");
});

$("#loginbox").mouseleave( function () {

    if (!$("#mainLoginForm").is(":focus")) {
        $("#accountLoginLi").removeClass("muestraLogin");
    }

});