window.PagSeguro =
  sessionId: '0a89a3cb287444e59066e4053f6a83f9'
  imageHost: 'https://stc.pagseguro.uol.com.br'
  image: {}

getGiftPriceAmount = ->
  parseFloat $('input[name=giftPrice]:checked', '#quota').val()

PagSeguro.startPaymentFlow = (event) ->
  @senderHash = PagSeguroDirectPayment.getSenderHash()
  PagSeguroDirectPayment.getPaymentMethods
    amount: getGiftPriceAmount()
    complete: @paymentMethodsCallback
  event.preventDefault()
  return

PagSeguro.paymentMethodsCallback = (response) ->
  if response.error
    console.log '1. paymentMethodsCallback -> error'
  else
    console.log '1. paymentMethodsCallback -> ok'
    PagSeguro.setPaymentMethods(response)
  return

PagSeguro.setPaymentMethods = (response) ->
  @APIResponse = response
  @paymentMethods = {}
  for own paymentMethod, methodParams of response.paymentMethods
    @paymentMethods[paymentMethod] = {}
    for own specificMethod, specificOptions of methodParams.options
      @paymentMethods[paymentMethod][specificMethod] = {}
      for own imageSize, imageObject of specificOptions.images
        @paymentMethods[paymentMethod][specificMethod][imageSize] = @imageHost + imageObject.path

$(document).ready ->
  PagSeguroDirectPayment.setSessionId PagSeguro.sessionId
  $('#quota input').on 'change', -> console.log 'valor', getGiftPriceAmount()
  return
