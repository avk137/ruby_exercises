# frozen_string_literal: true

def substrings(string, dictionary)
  # Приводим строку к нижнему регистру для нечувствительности к регистру
  string = string.downcase
  # Создаем хэш для хранения результатов
  result = {}

  # Проходим по каждому слову в словаре
  dictionary.each do |word|
    # Считаем количество вхождений слова в строке
    count = string.scan(word).count
    # Если количество больше 0, добавляем его в результат
    result[word] = count if count.positive?
  end

  result
end

# Пример использования
# dictionary=["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]
# string = "Howdy partner, sit down! How's it going?"

# substrings(string, dictionary)
