class LyricSnippet
  constructor: (termsHtml) ->
    modalTemplate = mytemplate["templates/terms_and_conditions_modal.tpl.html"]
    document.body.insertAdjacentHTML('beforeend', modalTemplate)

    waitModalTemplate = mytemplate["templates/wait_indicator.tpl.html"]
    document.body.insertAdjacentHTML('beforeend', waitModalTemplate)

    errorModalTemplate = mytemplate["templates/error.tpl.html"]
    document.body.insertAdjacentHTML('beforeend', errorModalTemplate)

    if termsHtml?
      document.getElementById('terms-container').innerHTML = termsHtml

    @modal = document.getElementById('tcModal')
    @waitModal = document.getElementById('waitModal')
    @errorModal = document.getElementById('errorModal')
    @closeButton = document.getElementsByClassName("close")[0]

    @closeButton.onclick = ->
      @modal.style.display = 'none'


    window.onclick = (event) ->
      if event.target == modal
        @modal.style.display = 'none'
      if event.target == errorModal
        @errorModal.style.display = 'none'

confirm: ->
  @modal.style.display = "block"

closeModal: ->
  @modal.style.display = "none"
  @errorModal.style.display = "none"

confirmed: ->
  if window.CustomEvent
    event = new CustomEvent('confirmationComplete')
  else
    event = document.createEvent('CustomEvent')
    event.initCustomEvent 'confirmationComplete', true, true
  document.dispatchEvent event

  @modal.style.display = 'none'
  @waitModal.style.display = "block"

advanceRequestComplete: (accessToken) ->
  @waitModal.style.display = "none"
  #window.open('http://vatm.dev:8080/#/advance?access_token=' + accessToken,'_blank')
  window.open('https://api.lyricfinancial.com/vatm/#/advance?access_token=' + accessToken,'_blank')

advanceRequestError: (error) ->
  document.getElementById('errorMessage').innerHTML = error.statusText
  @waitModal.style.display = "none"
  @errorModal.style.display = "block"

  
