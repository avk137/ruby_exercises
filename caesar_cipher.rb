# frozen_string_literal: true

# Класс для выполнения шифрования и дешифрования шифра Цезаря
class CaesarCipher
  # Метод для перевода строки с заданным сдвигом
  def translate(str, shift)
    result = '' # Инициализируем результирующую строку
    str.each_char do |char| # Проходим по каждому символу в строке
      result += process_char(char, shift) # Обрабатываем символ и добавляем его в результат
    end
    result # Возвращаем результирующую строку
  end

  # Ключевое слово private, означает, что остальные методы доступны только внутри класса
  private

  # Метод для обработки каждого символа
  def process_char(char, shift)
    # Проверяем, является ли символ буквой английского алфавита
    if char.ord.between?(65, 90) || char.ord.between?(97, 122)
      process_english_char(char, shift) # Обрабатываем английский символ
    # Проверяем, является ли символ буквой русского алфавита
    elsif char.ord.between?(1040, 1071) || char.ord.between?(1072, 1103)
      process_russian_char(char, shift) # Обрабатываем русский символ
    else
      char # Если это не буква, возвращаем символ без изменений
    end
  end

  # Метод для обработки английских символов
  def process_english_char(char, shift)
    base = char.ord < 91 ? 65 : 97 # Определяем базовый код символа (A или a)
    # Вычисляем код нового символа с учетом сдвига
    rotation = (((char.ord - base) + shift) % 26) + base
    rotation.chr # Возвращаем новый символ
  end

  # Метод для обработки русских символов
  def process_russian_char(char, shift)
    base = char.ord < 1072 ? 1040 : 1072 # Определяем базовый код символа (А или а)
    # Вычисляем код нового символа с учетом сдвига
    rotation = (((char.ord - base) + shift) % 33) + base
    rotation.chr(Encoding::UTF_8) # Возвращаем новый символ в кодировке UTF-8
  end
end
