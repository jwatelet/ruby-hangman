require_relative './display_word'

class Hangman
  def initialize
    @secret_word = random_word
    @display_word = DisplayWord.new(@secret_word)
    @tries = 10
  end

  def random_word
    File.read('google-10000-english-no-swears.txt')
        .lines
        .map(&:strip)
        .select { |word| word.length > 5 && word.length < 12 }
        .shuffle
        .take(1)
        .first
  end

  def gets_letter
    puts 'Enter a letter'
    choosen_letter = ''
    loop do
      choosen_letter = gets.chomp.downcase
      valid = false

      if choosen_letter.match?(/[a-z]/) && choosen_letter.length == 1
        valid = true
      else
        puts 'please enter just one letter'
      end

      break if valid
    end
    choosen_letter
  end

  def start
    loop do
      puts "You have #{@tries} tries left"
      guess_letter(gets_letter)

      puts @display_word

      break if win? || @tries.zero?
    end

    if win?
      puts 'You Win !'
    else
      puts "No more try, you're hanged :'()"
    end
  end

  def win?
    @display_word == @secret_word && @tries.positive?
  end

  def guess_letter(guessed_letter)
    @tries -= 1 unless @secret_word.include?(guessed_letter)
    @tries -= 1 if @display_word.word.include?(guessed_letter)

    @secret_word.split('').each_with_index do |char, index|
      @display_word.word[index] = guessed_letter if char == guessed_letter
    end
  end
end


