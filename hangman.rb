class Hangman
  def initialize
      
  end

  def game
    @secret_word = words.sample
    puts @secret_word

    @display = Array.new(@secret_word.length) {"_"}.join
    3.times do
      guess = gets
      compare(guess)
    end
    
  end

  def words
    f = File.open("google-10000-english-no-swears.txt", "r")
    words = []
    while line = f.gets do
      words << line.chomp
    end
    f.close
    words = words.select { |word| word.length >= 5 && word.length <= 12 }
  end

  def guess
    
  end

  def compare(guess)
    guess = guess.chomp.split("")
    secret_word = @secret_word.split("")
    @display = @display.split("")
    guess.each do |letter|
      if secret_word.include?(letter)
        secret_word.each_with_index do |secret_letter, i|
          @display[i] = letter if secret_letter == letter
        end
      end
    end
    @display = @display.join
    puts @display
  end

end

# f = File.open("google-10000-english-no-swears.txt", "r")
# words = []
# while line = f.gets do
#   words << line.chomp
# end
# f.close
# words = words.select { |word| word.length >= 5 && word.length <= 12 }
# puts words.sample

 Hangman.new.game