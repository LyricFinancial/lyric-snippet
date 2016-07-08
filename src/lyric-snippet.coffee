class LyricSnippet
  @modal
  @waitModal
  @errorModal
  @redirectModal
  @closeButton
  @vatmUrl
  @accessToken
  @strategy
  constructor: (termsHtml, strategy, asyncToken, vatmUrl) ->
    modalTemplate = mytemplate["templates/terms_and_conditions_modal.tpl.html"]
    document.body.insertAdjacentHTML('beforeend', modalTemplate)

    waitModalTemplate = mytemplate["templates/wait_indicator.tpl.html"]
    document.body.insertAdjacentHTML('beforeend', waitModalTemplate)

    errorModalTemplate = mytemplate["templates/error.tpl.html"]
    document.body.insertAdjacentHTML('beforeend', errorModalTemplate)

    redirectModalTemplate = mytemplate["templates/redirect_modal.tpl.html"]
    document.body.insertAdjacentHTML('beforeend', redirectModalTemplate)

    if termsHtml?
      document.getElementById('terms-container').innerHTML = termsHtml

    @strategy = LyricSnippet.strategy = strategy
    @asyncToken = LyricSnippet.asyncToken = asyncToken

    if vatmUrl?
      @vatmUrl = vatmUrl
    else
      @vatmUrl = 'https://vatm-stage.lyricfinancial.com'

    LyricSnippet.vatmUrl = @vatmUrl

    @modal = LyricSnippet.modal = document.getElementById('tcModal')
    @waitModal = LyricSnippet.waitModal = document.getElementById('waitModal')
    @errorModal = LyricSnippet.errorModal = document.getElementById('errorModal')
    @redirectModal = LyricSnippet.redirectModal = document.getElementById('redirectModal')
    @closeButton = LyricSnippet.closeButton = document.getElementsByClassName("close")[0]

    @closeButton.onclick = =>
      @modal.style.display = 'none'


    window.onclick = (event) =>
      if event.target == @modal
        @modal.style.display = 'none'
      if event.target == @errorModal
        @errorModal.style.display = 'none'


  confirm: ->
    @modal.style.display = "block"

  @closeModal: ->
    LyricSnippet.modal.style.display = "none"
    LyricSnippet.errorModal.style.display = "none"

  @confirmed: ->
    

    if window.CustomEvent
      event = new CustomEvent('confirmationComplete')
    else
      event = document.createEvent('CustomEvent')
      event.initCustomEvent 'confirmationComplete', true, true
    document.dispatchEvent event

    LyricSnippet.modal.style.display = 'none'

    if @strategy = 'async'
      LyricSnippet.redirectModal.style.display = 'none'
      window.open(LyricSnippet.vatmUrl + '/#/advance?async_token=' + LyricSnippet.asyncToken,'_blank')
      return

    LyricSnippet.waitModal.style.display = "block"

  @redirectToVatm: ->
    LyricSnippet.redirectModal.style.display = 'none'
    window.open(LyricSnippet.vatmUrl + '/#/advance?access_token=' + LyricSnippet.accessToken,'_blank')

  advanceRequestComplete: (accessToken) ->
    @waitModal.style.display = "none"
    @accessToken = LyricSnippet.accessToken = accessToken

    switch @strategy
      when 'syncManualRedirect'
        @redirectModal.style.display = "block"
      else
        LyricSnippet.redirectToVatm()


  advanceRequestError: (error) ->
    document.getElementById('errorMessage').innerHTML = error.statusText
    @waitModal.style.display = "none"
    @errorModal.style.display = "block"

  
