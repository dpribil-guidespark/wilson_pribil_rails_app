$(function () {

    // send a new mail after a challenge was successfully created
    $('#autoEmail').bind('click', function(){
        window.location.href = $(this).attr('href');
        $(this).remove();
    });

    $('#autoEmail').click();

    // set the param after switching the mail option
    $("[name='gg-checkbox-mail']").bootstrapSwitch();

    $("[name='gg-checkbox-mail']").bootstrapSwitch().on('switchChange.bootstrapSwitch', function (e, data) {
        $('#challenge_send_notification_email').attr('value', $(this).bootstrapSwitch('state'));
    });

})
