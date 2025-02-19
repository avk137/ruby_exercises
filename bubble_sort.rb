# frozen_string_literal: true

# Пузырьковая сортировка
def bubble_sort(array)
  # Инициализируем переменную для отслеживания перестановок
  swapped = true
  # Запускаем цикл для прохода по массиву и перестановок
  while swapped
    swapped = false
    (array.length - 1).times { |i| swapped = swap_elements(array, i, swapped) }
  end

  array
end

# Метод для перестановки элементов
def swap_elements(array, index, swapped)
  if array[index] > array[index + 1]
    array[index], array[index + 1] = array[index + 1], array[index]
    swapped = true
  end

  swapped
end

# Пример использования
# arr = [4, 3, 78, 2, 0, 2]
# bubble_sort(arr)
