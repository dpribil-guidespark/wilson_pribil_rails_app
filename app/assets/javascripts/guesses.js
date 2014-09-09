$(function () {

    $("[name='gg-checkbox']").bootstrapSwitch().on('switchChange.bootstrapSwitch', function (e, data) {

        $.ajax({
            type: "POST",
            url: '/guesses/update_guess_status',
            data: {
                _method: 'PUT',
                guess_id: $(this).attr('data-guess-id'),
                guess_status: $(this).bootstrapSwitch('state') ? 1 : 0
            },
            dataType: 'json',
            complete: function (data) {
                console.log($(data).find('input'));
            }
        });
    });

});
