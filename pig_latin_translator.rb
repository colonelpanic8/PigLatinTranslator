class PigLatinWord

  @@letters = ('a' .. 'z').to_a
  @@vowels = %w(a e i o u)
  @@consonants = @@letters - @@vowels

  attr_reader :word
  
  def initialize(word)
    @word = word
  end

  def is_capitalized?
    word == word.capitalize
  end

  def translate
    normalized_word = word.downcase.gsub(/[^a-z]/, '')
    pig_word_start = get_starting_pig_index(normalized_word)
    pig_latin_word = [normalized_word[pig_word_start, normalized_word.length],
                      normalized_word[0...pig_word_start],
                      'ay'].join('')
    pig_latin_word.capitalize! if self.is_capitalized?
    pig_latin_word += word.downcase.gsub(/[a-z]/, '')
    return pig_latin_word
  end

  def to_s
    return "#{self.translate}"
  end

  private

  def get_starting_pig_index(word)
    pig_word_start = 0
    word.each_char.with_index do |character, index|
      if @@vowels.include?(character)
        pig_word_start = word[index-1..index] == 'qu' ? index + 1 : index
        break 
      end
    end
    return pig_word_start
  end
end

class PigLatinTranslator

  def initialize(sentence)
    @pig_latin_words = sentence.split(' ').map {|word| PigLatinWord.new(word)}
  end
  
  def translation
    return @pig_latin_words.join(' ')
  end
end
