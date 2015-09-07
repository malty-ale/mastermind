class Game
  attr_reader :code, :solved, :guesses_left
  
  def initialize
    puts "Welcome!  Would you like the code creator to be a computer?"
    gets.chomp.downcase == "yes" ? (@creator = ComputerCreator.new) : (@creator = HumanCreator.new)
    puts "Would you like the code guesser to be a human?"
    gets.chomp.downcase == "yes" ? (@guesser = HumanGuesser.new) : (@guesser = ComputerGuesser.new)
    
    @code = []
    @guess = []
    @colors = ["red", "blue", "green", "yellow"]
    create_code(@code)
    create_code(@guess)
    
    @guesses_left = 12
    
    @solved = false
  end
  
  def start
    if @creator.class == HumanCreator
    end
    
    while @guesses_left > 0
      @guesses_left -= 1
      if @guesser.class == HumanGuesser
        human_guess
      else
        computer_guess
      end
    end
    
    if !@solved
      puts "The code was not cracked, game over"
    end
  end
  
  private
  
  def create_code(array)
    4.times do
      array.push(@colors.sample)
    end
  end
  
  def computer_guess
    @position_right = 0
    @color_right = 0
    
    right_color_and_position
    
    @guess.each_with_index do |i,j|
      if @code[j] != i
        @guess[j] = @colors.sample
      end
    end
    
    if @position_right == @code.length
      @solved = true
      @guesses_left = 0
      puts "Congrats, you solved the code!"
    else
      puts "You guessed #{@color_right} with the right color only and #{@position_right} with the right color and position."
      puts "You have #{@guesses_left} guesses left."
    end
  end
  
  def human_guess
    puts "What would you like to guess (reminder, colors are red, blue, green, and yellow)."
    @guess = gets.chomp.split(" ")
    code_test
  end
  
  def code_test
    @color_right = 0
    @position_right = 0
    
    right_color
    
    right_color_and_position
    
    @color_right = @color_right - @position_right
    
    if @position_right == @code.length
      @solved = true
      @guesses_left = 0
      puts "Congrats, you solved the code!"
    else
      puts "You guessed #{@color_right} with the right color only and #{@position_right} with the right color and position."
      puts "You have #{@guesses_left} guesses left."
    end
  end
  
  def right_color_and_position
    @guess.each_with_index do |i,j|
      if @code[j] == i
        @position_right += 1
      end
    end
  end
  
  def right_color
    @guess.each do |i|
      test_code = []
      @code.each {|i| test_code.push(i)}
      
      if test_code.include? i
        @color_right += 1
        test_code.delete_at(test_code.index(i))
      end
    end
  end    
    
end

class ComputerCreator
end

class HumanCreator
  attr_accessor :name
end

class HumanGuesser
  attr_accessor :name
end

class ComputerGuesser
end