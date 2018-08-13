require 'rest-client'
require 'json'
require 'pry'

def get_film_urls_with_character(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  array_of_characters = response_hash["results"]
  loop do
    if array_of_characters.any? {|hash| hash["name"] == character}
      array_of_characters.each do |hash|
        if hash["name"] == character
          return hash["films"]
        end
      end
    elsif response_hash["next"].is_a?(String)
      new_url = response_hash["next"]
      response_string = RestClient.get(new_url)
      response_hash = JSON.parse(response_string)
      array_of_characters = response_hash["results"]
    else
      break
    end
  end
end

def get_character_movies_from_api(array_of_film_urls)

  films_array = []
  array_of_film_urls.each do |url|
    response_string = RestClient.get(url)
    response_hash = JSON.parse(response_string)
    films_array << response_hash
  end
  films_array

end

def print_movies(films_array)
  films_array.each {|film| puts film["title"]}
end

def show_character_movies(character)
  array_of_film_urls = get_film_urls_with_character(character)
  films_array = get_character_movies_from_api(array_of_film_urls)
  print_movies(films_array)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
