Template.api.rendered = ->
  $('body').css('background-color', Session.get('color'))

  if /iPad|iPhone/i.test(navigator.userAgent)
    return $('#copy-trigger').hide()

  clip = new ZeroClipboard($('#copy-trigger'), {
    moviePath: '/ZeroClipboard.swf'
  })

  clip.on 'complete', ->
    $('#copy-trigger').tooltip('show')
    setTimeout ->
      $('#copy-trigger').tooltip('hide')
    , 1000

Template.api.helpers
  'key': -> if Meteor.user().profile then Meteor.user().profile.apiKey

Template.api.events
  'click .create-new-key': (e) ->
    e.preventDefault()
    Meteor.call('updateApiKey', (err, key) ->
      $('[name=key]').val(key)
    )

  'submit form': (e) ->
    e.preventDefault()
