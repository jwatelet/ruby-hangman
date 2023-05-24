class DisplayWord
  attr_reader :word

  def initialize(secret_word)
    @word = secret_word.split('').map { |_char| '_' }
  end

  def ==(other)
    @word.join('') == other
  end

  def to_s
    @word.join(' ')
  end
end