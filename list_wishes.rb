# А теперь стремительно напишите для вашего «Сундука желаний» скрипт, который выводит
#
# желания, которые уже должны были сбыться на текущий день;
# желание, которым ещё предстоит сбыться.

require 'date'
require 'rexml/document'
require_relative 'lib/wish.rb'

# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# путь к файлу
file_path = File.dirname(__FILE__) + "/data/chest.xml"
file = File.new(file_path, "r:UTF-8")
doc = REXML::Document.new(file)
file.close

list_wishes =[]

doc.elements.each("/wishes/wish") do |element|
  list_wishes << Wish.new(element)
end

puts 'Эти желания должны были сбыться к сегодняшнему дню'
list_wishes.each { |item| puts item if item.overdue?}

puts 'А этим желаниям ещё предстоит сбыться'
list_wishes.each { |item| puts item unless item.overdue?}

