require './pig_latin_translator.rb'

while true
  puts PigLatinTranslator.new(gets.chomp).translation
end
