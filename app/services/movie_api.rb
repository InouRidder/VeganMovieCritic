require 'json'
require 'rest-client'

class MovieApi
  def initialize(title)
    @title = title
  end

  def search
    url = "http://www.omdbapi.com/?apikey=6866fd10&t=#{@title}&y=&plot=short&r=json"
    if returned_data = RestClient.get(url)
      data = JSON.parse(returned_data)
      unless data["Response"] == "False"
        @movie = build_movie(data)
      end
    end
    @movie
  end

  def build_movie(data)
    movie = Movie.new
    movie.title = data["Title"]
    movie.released = data["Released"]
    movie.runtime = data["Runtime"]
    movie.genre = data["Genre"]
    movie.plot = data["Plot"]
    movie.actors = data["Actors"]
    movie.awards = data["Awards"]
    movie.imdb_poster = data["Poster"]
    movie.imdbrating = data["imdbrating"]
    movie.country = data["Country"]
    movie.language = data["Language"]
    movie.director = data["Director"]
    return movie if movie.save!
  end
end
