class DeezerApi
  API_ENDPOINT = 'http://api.deezer.com/search'

  def self.search(query)
    json_response_for(query).map do |track|
      {
        title: track['title'],
        provider: 'deezer',
        provider_track_id: track['id'],
        duration: track['duration'] * 1000,
        artist: track['artist']['name'],
        image_url: track['album']['cover_small']
      }
    end
  end

  private

  def self.json_response_for(query)
    json_response = JSON.parse(RestClient.get("#{API_ENDPOINT}?q=#{query}"))
    json_response['data']
  end
end
