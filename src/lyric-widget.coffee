class LyricWidget
  @advanceStatusData
  @advanceUrl
  constructor: (vendorClientAccountId, advanceUrl) ->
    if advanceUrl?
      @advanceUrl = advanceUrl
    else
      @advanceUrl = 'https://integrationservices.lyricfinancial.com/widgetAPI/v1/clients/' + vendorClientAccountId + '/advanceStatus'

  loadData: (token)->
    request = new XMLHttpRequest
    request.open 'GET', @advanceUrl, true
    request.setRequestHeader('Authorization', 'Bearer ' + token)
    me = this

    promise = new Promise((resolve, reject) ->

      request.onload = ->
        if request.status >= 200 and request.status < 400
          me.advanceStatusData = JSON.parse(request.responseText)
          resolve 'Successfully loaded data'
        else
          resolve "Data didn't load. Error widget will display."

      request.onerror = ->
        resolve "Data didn't load. Error widget will display."

      request.send()
    )
    return promise

  getWidget: ->
    template = mytemplate["templates/advance_status_error_widget.tpl.html"]

    if isBlank(@advanceStatusData) == false
      template = mytemplate["templates/advance_status_widget.tpl.html"]
      template = template.replace("{{advanceLimit}}", '$' + @advanceStatusData.advanceLimit.toFixed(2))
      template = template.replace("{{currentBalance}}", '$' + @advanceStatusData.currentBalance.toFixed(2))
      template = template.replace("{{availableBalance}}", '$' + @advanceStatusData.availableBalance.toFixed(2))
    return template

  isBlank = (str) ->
    return (!str || /^\s*$/.test(str))