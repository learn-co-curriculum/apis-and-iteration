require 'rest-client'
require 'json'
require 'pry'

def film_url_array(character)
    
    all_characters = RestClient.get('http://www.swapi.co/api/people/')
    character_hash = JSON.parse(all_characters)

    bio_hash_array = character_hash["results"].select {|bio_hash| bio_hash["name"] == character}
    bio_hash_array[0]["films"]
end

def parser(array)
    array.map do |film_url|
        film = RestClient.get(film_url)
        JSON.parse(film)
    end
end

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

#film_apis = []
#
#character_hash["results"].each do |bio_stats|
#    if bio_stats["name"] == character
#        film_apis = bio_stats["films"]
#    end
#end
#
#  film_apis
#
#  parsed_films = film_apis.map do |film_url|
#     film = RestClient.get(film_url)
#     JSON.parse(film)
#  end
#
#  parsed_films
#
parser(film_url_array(character))

end



def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |movie_stats|
      puts movie_stats["title"]
  end
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
