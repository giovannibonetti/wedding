window.PagSeguro =
  imageHost: 'https://stc.pagseguro.uol.com.br'
  sessionId: '0a89a3cb287444e59066e4053f6a83f9'

getGiftPriceAmount = ->
  parseFloat $('input[name=giftPrice]:checked', '#quota').val()

PagSeguro.startPaymentFlow = ->
  @senderHash = PagSeguroDirectPayment.getSenderHash()
  PagSeguroDirectPayment.getPaymentMethods
    amount: getGiftPriceAmount()
    complete: @displayPaymentMethods
  return

# PagSeguro flow - Callback #1
PagSeguro.displayPaymentMethods = (response) ->
  if response.error
    console.log '1. displayPaymentMethods -> error'
  else
    console.log '1. displayPaymentMethods -> ok'
    PagSeguro.paymentMethods = response.paymentMethods
  return

$(document).ready ->
  PagSeguroDirectPayment.setSessionId PagSeguro.sessionId
  $('#quota input').on 'change', -> console.log 'valor', getGiftPriceAmount()
  return
