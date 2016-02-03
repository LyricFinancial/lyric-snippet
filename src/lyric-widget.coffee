class LyricWidget
  @advanceStatusData
  constructor: ->

  loadData: (token)->
    request = new XMLHttpRequest
    request.open 'GET', "http://demo.dev:8082/clients/a/advanceStatus", true
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
      template = template.replace("{{advanceAmount}}", '$' + @advanceStatusData.advanceAmount)
      template = template.replace("{{amountRepaid}}", '$' + @advanceStatusData.amountRepaid)
      template = template.replace("{{amountRemaining}}", '$' + @advanceStatusData.amountRemaining)
      template = template.replace("{{availableBalance}}", '$' + @advanceStatusData.availableBalance)
    return template

  isBlank = (str) ->
    return (!str || /^\s*$/.test(str))