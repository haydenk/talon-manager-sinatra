
$(function() {

    $('#auth_type').on('change', function() {
        if (this.value.toLowerCase() === 'none') {
            toggleBasicAuth();
        }

        if (this.value.toLowerCase() === 'basic') {
            toggleBasicAuth();
        }

        function toggleBasicAuth() {
            $('fieldset.basic').toggle();
            inputs = $('fieldset.basic').find('input');
            inputs.prop('disabled', function() { return !$(this).prop('disabled'); });
        }
    });

});