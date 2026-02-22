class Hangman
  def game
    @secret_word = words.sample
    # puts @secret_word
    @display = Array.new(@secret_word.length) { '_' }.join
    remaining_guesses = 8
    until remaining_guesses == 0
      @right_guess = 0
      guess = gets.downcase
      compare(guess)
      remaining_guesses += @right_guess
      remaining_guesses -= 1
    end
    puts 'the secret word was: ' + @secret_word
  end

  private

  def words
    f = File.open('google-10000-english-no-swears.txt', 'r')
    words = []
    while line = f.gets
      words << line.chomp
    end
    f.close
    words = words.select { |word| word.length >= 5 && word.length <= 12 }
  end

  def compare(guess)
    guess = guess.chomp.split('')
    secret_word = @secret_word.split('')
    @display = @display.split('')
    guess.each do |letter|
      next unless secret_word.include?(letter)

      @right_guess = 1
      secret_word.each_with_index do |secret_letter, i|
        @display[i] = letter if secret_letter == letter
      end
    end
    @display = @display.join
    puts @display
  end
end

Hangman.new.game
