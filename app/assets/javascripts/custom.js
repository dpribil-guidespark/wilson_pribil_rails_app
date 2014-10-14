$(function () {
    function fadeAlert() {
        $('.alert').removeClass('in');
    }

    function removeAlert() {
        $('.alert').remove();
    }

    window.setTimeout(fadeAlert, 3000);
    window.setTimeout(removeAlert, 3200);

});