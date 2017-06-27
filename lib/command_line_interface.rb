def welcome
  # puts out a welcome message here!
  puts "Hello! Welcome to a galaxy far, far away!"
end

def get_character_from_user
  puts "please enter a character"
  user_input = gets.chomp
  return user_input
  # use gets to capture the user's input. This method should return that input, downcased.
end

