$ = window.jQuery

$(document).ready ->
  playlist_id = $('#searchbox').data 'playlistId'

  $(document).on 'click', '.like-vote-container, .dislike-vote-container', ->
    $this = $(@)
    meth = if $this.data('action') is 'undefined' then 'PUT' else 'DELETE'
    $.ajax
      url: $this.data('url')
      method: meth
      success: ->
        if meth is 'PUT'
          $this.addClass 'voted'
        else
          $this.removeClass 'voted'
    false

  window.refresh = ->
    $.ajax
      url: "/api/v1/playlists/#{playlist_id}"
      method: "GET"
      success: (json) ->
        html = ""
        if json.tracks?
          for item in json.tracks
            html += """
            <div class="track-container" data-provider="#{item.provider}" data-track="#{item.provider_track_id}" data-duration="#{item.duration}" data-id="#{item.id}">
              <div class="default-song-icon-container"><img src="#{item.image_url}" /></div>
              <div class="track-info-container">
                <h5>#{item.artist}</h5>
                <p>#{item.title}</p>
              </div>
              <div class="vote-container">
                <div class="like-vote-container" data-action="#{item.love}" data-url="#{item.love_url}">
                  <svg width="30px" height="25px" viewBox="0 0 30 25" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <title>like-icon</title>
                    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                      <path d="M14.9986317,5.10102392 L11.9479079,2.05030011 C9.21457473,-0.683033054 4.78173522,-0.683717712 2.04806518,2.04995233 C-0.680042392,4.7780599 -0.685449152,9.21593293 2.04841297,11.9497951 L12.294081,22.195463 L14.6442593,24.8097213 L27.4344266,12.0195539 C30.1242172,9.32976336 30.1242178,4.96253002 27.4305905,2.2689027 L27.2855829,2.12389518 C24.5930806,-0.56860717 20.2904048,-0.508314434 17.6778002,2.26107547 L14.9986317,5.10102392 Z" id="Combined-Shape" stroke="#FF4927"></path>
                    </g>
                  </svg>
                </div>
                <div class="dislike-vote-container" data-action="#{item.hate}" data-url="#{item.hate_url}">
                  <svg width="31px" height="25px" viewBox="0 0 31 25" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <title>dislike</title>
                    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                      <path d="M2.04841297,11.9480578 C-0.685449152,9.21419565 -0.680042392,4.77632262 2.04806518,2.04821504 C4.78173522,-0.685454998 9.22045897,-0.678886087 11.9441546,2.04480959 C11.9441546,2.04480959 10.6640212,0.764676143 14.2914285,4.39208342 C14.2914282,4.39208434 10.0926251,11.5908873 10.0926251,11.5908873 L17.9999993,14.9982622 L14.0547858,23.9544306 L2.04841297,11.9480578 Z M12.5000003,10.9982624 C12.5000003,10.9982624 16.5382905,4.11496292 16.4709723,4.04764482 C17.4335407,3.10140386 18.3747462,2.17978149 18.3747462,2.17978149 C21.1547228,-0.545670466 25.6423226,-0.521102449 28.387089,2.22366393 L28.3290844,2.16565937 C31.078772,4.91534693 31.0707302,9.38151309 28.3287672,12.1234761 L15.6442593,24.807984 L20.3104039,14.1878584 L12.5000003,10.9982624 Z" id="Combined-Shape" stroke="#FF4927"></path>
                    </g>
                  </svg>
                </div>
              </div>
            </div>
            """
        $('.playlist-container').html html
        $('.like-vote-container, .dislike-vote-container').each ->
          $(@).addClass('voted') if $(@).data('action') isnt 'undefined'
  window.refresh()

  setInterval ->
    window.refresh()
  , 3000