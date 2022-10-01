# Напишите программу «Сундук желаний».

  # Программа спрашивает у пользователя в консоли, чего он хочет и до какой даты он хочет,
  # чтобы его желание исполнилось, а потом записывает это всё в XML-файл.

# В этом сундуке хранятся ваши желания.
#   Чего бы вы хотели?
#
# > Сделать курс по Node.JS
#
# До какого числа вы хотите осуществить это желание?
# (укажите дату в формате ДД.ММ.ГГГГ)
#
# > 8.3.2018
#
# Ваше желание в сундуке

require 'date'
require 'rexml/document'

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

# проверка наличия файла, если нет - то создаем
unless File.exist?(file_path)
  File.open(file_path, "w:UTF-8") do |file|
    file.puts("<?xml version='1.0' encoding='UTF-8'?>")
    file.puts("<wishes/>")
  end
end

# пользовательские данные
puts "Чего бы вы хотели?"
input_wish = STDIN.gets.chomp

puts "До какого числа осуществить желание?"
puts "(укажите дату в формате ДД.ММ.ГГГГ)"
date = STDIN.gets.chomp
date_wish = Date.parse(date)

# открываем фалй и парсим в хмл
file = File.new(file_path, "r:UTF-8")
doc = REXML::Document.new(file)
file.close

# добавляем элемент и текст в хмл структуру
wishes = doc.elements.find("*/wishes").first
wish = wishes.add_element("wish", {"date" => date_wish.→})
wish.text = input_wish

# сохраняем наш новый хмл
file = File.new(file_path, "w:UTF-8")
doc.write(file, 2)
file.close

puts "Ваше желание в сундуке"