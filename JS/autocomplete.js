function changeInput(val) {

    var parameters = {
        "search" : val
    };
    $.ajax({
        data:  parameters,
        url:   'quickSearch.php',
        type:  'post',
        beforeSend: function () {
            //$("#quickSearchResult").html("...");
        },
        success:  function (response) {
            $("#quickSearchResult").show();
            if(val == ""){
                $("#quickSearchResult").hide();
            }
            else if (response == "<ul id=\"quickSearchResults\"></ul>"){
                $("#quickSearchResult").html("");
            }
            else {
                $("#quickSearchResult").html(response);
            }
        }
    });

}