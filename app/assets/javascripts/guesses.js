$(function () {
    console.log('jQuery loaded!');
    $('input').click(function () {
        if ($(this).attr('id') != "guess_eval_checkbox")
            return;

        var button = $(this);
        button.prop('disabled', true);

        $.ajax({
            type: "POST",
            url: '/guesses/update_guess_status',
            data: {
                _method: 'PUT',
                guess_id: $(this).attr('data-guess-id'),
                guess_status: $(this).is(":checked") ? 1 : 0
            },
            dataType: 'json',
            complete: function (data) {
                console.log($(data).find('input'));
                button.prop('disabled', false);
            }
        });
    })
});
