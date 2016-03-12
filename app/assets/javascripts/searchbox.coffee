$ = window.jQuery

$(document).ready ->
  $(document).on 'click', '.search_results', ->
    playlist_id = $('#searchbox').data('playlistId')
    $.ajax
      url: "/api/v1/playlists/#{playlist_id}/tracks"
      method: 'POST'
      data: { track: $(@).data() }

  ajax_request = null

  $('#searchbox').on 'keyup', ->
    if $(@).val().length >= 3
      if ajax_request?
        ajax_request.abort()
      ajax_request = $.ajax
        url : '/api/v1/search'
        method: 'GET'
        data :
          q: encodeURIComponent $(@).val()
        datatype: 'json'
        success: (json) ->
          html = ''
          for i in json
            html += """
            <a class="search_results" href="#"
              data-title="#{i.title}"
              data-provider="#{i.provider}"
              data-provider_track_id="#{i.provider_track_id}"
              data-duration="#{i.duration}"
              data-artist="#{i.artist}"
              data-image_url="#{i.image_url}"
            >
              #{i.artist} - #{i.title}
            </a>
            """
          $("body").append '<div id="search_results" />'
          $('#search_results').html html
