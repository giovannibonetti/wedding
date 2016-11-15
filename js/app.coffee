startPaymentFlow = ->
  window.senderHash = PagSeguroDirectPayment.getSenderHash()
  amount = parseFloat($('input[name=giftPrice]:checked', '#quota').val())
  console.log amount
  PagSeguroDirectPayment.getPaymentMethods
    amount: amount
    complete: displayPaymentMethods
  return

displayPaymentMethods = (response) ->
  console.log 'displayPaymentMethods'
  if !response.error
    console.log response.paymentMethods
  return

PagSeguroDirectPayment.setSessionId '0a89a3cb287444e59066e4053f6a83f9'
$(document).ready ->
  $('#quota input').on 'change', ->
    console.log 'valor', $('input[name=giftPrice]:checked', '#quota').val()
    return
  return