class Hangman
  def initialize
      
  end

  def game
    @secret_word = words.sample
    puts @secret_word
    i = 0
    while i < 1 
      @guess = gets
      i += 1
    end
    compare
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

  def compare
    display = []
    @secret_word.length.times do |i|
      if @guess.chomp.split("")[i] == @secret_word.split("")[i]
        display[i] = @secret_word.split("")[i]
      else
        display << "_"
      end
    end
    puts display.join
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
