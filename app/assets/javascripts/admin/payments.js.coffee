$ ->
  $(document).on 'input', '.payment_payment_date select, #payment_loan_id, #payment_amount, #new_payment select', ->
    loan_id = $('#payment_loan_id').val()
    return false if loan_id.length == 0
    day = $('#payment_payment_date_3i').val()
    month = $('#payment_payment_date_2i').val()
    year = $('#payment_payment_date_1i').val()
    url = $('#payment_late_fee').data('lfee-url')
    amount = $('#payment_amount').val()
    $.get url, { payment_date: "#{year}-#{month}-#{day}", loan_id: loan_id, amount: amount }, (response) ->
      $('#payment_late_fee').val(response)