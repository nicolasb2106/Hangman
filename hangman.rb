require 'yaml'

class Hangman
  def game
    saved_data = nil
    puts "Drücke '1' für ein neues Spiel oder '2' zum Laden."
    choice = gets.chomp

    saved_data = load_game if choice == '2'

    if saved_data
      @secret_word = saved_data['secret_word']
      @display = saved_data['display']
      @remaining_guesses = saved_data['remaining_guesses']
      puts @display
    else
      @secret_word = words.sample
      @display = Array.new(@secret_word.length) { '_' }.join
      @remaining_guesses = 8
    end

    until @remaining_guesses == 0 || !@display.include?('_')
      @right_guess = 0
      puts "Remaining guesses: #{@remaining_guesses}"
      guess = gets.chomp.downcase

      if guess == 'save'
        save_game
        return
      end

      compare(guess)
      @remaining_guesses -= 1 unless @right_guess == 1
    end
    if @display.include?('_')
      puts "You lost! The secret word was: #{@secret_word}"
    else
      puts "You won! The word was: #{@secret_word}"
    end
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
    guess = guess.split('')
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

  def save_game
    File.open('save_game.yaml', 'w') do |f|
      f.write(YAML.dump({
                          'secret_word' => @secret_word,
                          'display' => @display,
                          'remaining_guesses' => @remaining_guesses
                        }))
    end
    puts 'Spielstand unter gesichert.'
  end

  def load_game
    return nil unless File.exist?('save_game.yaml')

    YAML.safe_load(File.read('save_game.yaml'))
  rescue StandardError
    nil
  end
end

Hangman.new.game
