toastr.options = {
    "positionClass": "toast-top-center",
    "showDuration": "200",
    "hideDuration": "450",
    "timeOut": "2000"
};

$("#log_in_a").attr("href", "pages/account/login.jsp?href=" + window.location.href);

function logout() {
    $.ajax({
        url: 'logout',
        type: 'POST',
        dataType: 'text',
        data: {
        },
        success: function(){
            toastr.success("log out success");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function(error){
            console.log(error);
            toastr.error(JSON.parse(error.responseText).message);
        }
    })
}