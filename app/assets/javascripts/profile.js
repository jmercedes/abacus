$(function () {
    var $wizard = $('#fuelux-wizard'),
        $btnPrev = $('.wizard-actions .btn-prev'),
        $btnNext = $('.wizard-actions .btn-next'),
        $btnFinish = $(".wizard-actions .btn-finish");

    $wizard.wizard().on('finished', function(e) {
        // wizard complete code
    }).on("changed", function(e) {
        var step = $wizard.wizard("selectedItem");
        // reset states
        $btnNext.removeAttr("disabled");
        $btnPrev.removeAttr("disabled");
        $btnNext.show();
        $btnFinish.hide();

        if (step.step === 1) {
            $btnPrev.attr("disabled", "disabled");
        } else if (step.step === 4) {
            $btnNext.hide();
            $btnFinish.show();
        }
    });

    $btnPrev.on('click', function() {
        $wizard.wizard('previous');
    });
    $btnNext.on('click', function() {
        $wizard.wizard('next');
    });
});

