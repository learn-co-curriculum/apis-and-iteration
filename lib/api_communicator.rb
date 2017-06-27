require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character, api = 'http://www.swapi.co/api/people/')
  #make the web request
  all_characters = RestClient.get(api)
  character_hash = JSON.parse(all_characters)
  character_hash["results"].each do |character_bios|
    if character_bios["name"].downcase == character
      return parse_info_from_api(character_bios["films"])
    end
  end
  if character_hash["next"] == nil
    "invalid"
    else
  return change_page(character, character_hash["next"])
  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def change_page(character, next_page)
  get_character_movies_from_api(character, next_page)
end

def parse_info_from_api(links) #take are array of API links and return parsed data
  links.collect do |api|
    JSON.parse(RestClient.get(api))
  end
end

def parse_character_movies(films_hash)
  if films_hash == "invalid"
    puts "Invalid character name"
  else
    # some iteration magic and puts out the movies in a nice list
    film_titles = films_hash.collect {|film_data| film_data["title"]}
    film_titles.each_with_index {|title, index| puts "#{index + 1}. #{title}"}
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

