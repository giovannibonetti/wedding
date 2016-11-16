angular
  .module 'wedding', ['wedding.routes']
  .controller 'AppCtrl', ->
    return

angular
  .module 'wedding.routes', ['ui.router']
  .config ["$locationProvider", "$stateProvider", "$urlRouterProvider", ($locationProvider, $stateProvider, $urlRouterProvider) ->
    # $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise '/'
    $stateProvider
      .state 'wedding',
        url: '/'
        template: '<h2>Casamento</h2>'
        controller: ->
          return

      .state 'wedding.gifts',
        url: '/lista-de-presentes'
        template: '<h2>Casamento</h2>'
        controller: ->
          return
    return
  ]

window.PagSeguro =
  sessionId: '0a89a3cb287444e59066e4053f6a83f9'
  imageHost: 'https://stc.pagseguro.uol.com.br'

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
    i = _.camelCase(paymentMethod)
    @paymentMethods[i] = {}
    for own specificMethod, specificOptions of methodParams.options
      j = _.camelCase(specificMethod)
      @paymentMethods[i][j] = _.pick(specificOptions, ['displayName', 'code'])
      @paymentMethods[i][j].available = specificOptions.status is 'AVAILABLE'
      @paymentMethods[i][j].images = {}
      for own imageSize, imageObject of specificOptions.images
        k = _.camelCase(imageSize)
        @paymentMethods[i][j].images[k] = @imageHost + imageObject.path

$(document).ready ->
  PagSeguroDirectPayment.setSessionId PagSeguro.sessionId
  $('#startPaymentFlow').attr('disabled', null)
  $('#quota input').on 'change', -> console.log 'valor', getGiftPriceAmount()
  return
