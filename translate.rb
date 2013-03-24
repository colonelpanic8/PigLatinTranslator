require './pig_latin_translator.rb'

translator = PigLatinTranslator.new

while true
  word_to_translate = gets.chomp
  puts translator.translate(word_to_translate)
end
