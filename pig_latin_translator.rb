class PigLatinTranslator

  @@letters = ('a' .. 'z').to_a
  @@vowels = %w(a e i o u)
  @@consonants = @@letters - @@vowels
  
  def translate(sentence)
    return sentence.split(' ').map {|word| translate_word(word)}.join(' ')
  end

  def translate_word(word)
    normalized_word = word.downcase.gsub(/[^a-z]/, '')
    pig_word_start = get_starting_pig_index(normalized_word)
    pig_latin_word = [normalized_word[pig_word_start, normalized_word.length],
                      normalized_word[0...pig_word_start],
                      'ay'].join('')
    pig_latin_word.capitalize! if self.is_capitalized?(word)
    pig_latin_word += word.downcase.gsub(/[a-z]/, '')
    return pig_latin_word
  end
  
  def is_capitalized?(word)
    word == word.capitalize
  end
 
  def has_punctuation?(word)
    !@@letters.include?(word.downcase[-1])
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
