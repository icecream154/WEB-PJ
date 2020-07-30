                </div>
            </div>
        </div>
    </body>
</html>

<script src="<%=request.getContextPath()%>/static/js/jquery-3.4.1.js"></script>
<script src="<%=request.getContextPath()%>/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/toastr.min.js"></script>
<script>
    toastr.options = {
        "positionClass": "toast-top-center",
        "showDuration": "200",
        "hideDuration": "450",
        "timeOut": "2000"
    };

    $("#log_in_a").attr("href", "<%=request.getContextPath()%>/pages/account/login.jsp?href=" + window.location.href);

    function logout() {
        $.ajax({
            url: '<%=request.getContextPath()%>/logout',
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
</script>