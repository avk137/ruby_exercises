# frozen_string_literal: true

# Класс игры Крестики-нолики
class TicTacToe
  def initialize
    # Создаем игровое поле 3x3 из двумерного массива заполненное пробелами
    @board = Array.new(3) { Array.new(3, ' ') }
    # Определяем первого игрока ('X')
    @current_player = 'X'
  end

  # Основной игровой цикл
  def play
    loop do
      # Выводим игровое поле
      display_board
      # Обрабатываем ход игрока
      player_move
      # Проверяем, завершена ли игра
      break if game_over?

      # Меняем текущего игрока
      switch_player
    end
    # Выводим финальное состояние доски
    display_board
    # Выводим сообщение о результате
    puts result_message
  end

  # Далее приватные функции
  private

  # Отображаем текущее состояние игрового поля с расскрашиванием значений
  def display_board
    @board.each { |row| puts row.map { |cell| colorize(cell) }.join(' | ') }
  end

  # Окрашиваем 'X' в красный, 'O' в синий, остальные остаются без изменений
  def colorize(symbol)
    case symbol
    when 'X' then "\e[31mX\e[0m" # Красный цвет
    when 'O' then "\e[34mO\e[0m" # Синий цвет
    else symbol
    end
  end

  # Запрашиваем у игрока ввод и обрабатываем его ход
  def player_move
    loop do
      print "Игрок #{@current_player}, введите строку и столбец без пробела (0-2): "
      row, col = gets.chomp.split('').map(&:to_i)
      return @board[row][col] = @current_player if valid_move?(row, col)

      # Сообщаем об ошибке
      puts 'Неверный ход. Попробуйте снова.'
    end
  end

  # Проверяем, что ход находится в пределах доски и клетка не занята
  def valid_move?(row, col)
    row.between?(0, 2) && col.between?(0, 2) && @board[row][col] == ' '
  end

  # Переключаем текущего игрока ('X' -> 'O' и наоборот)
  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  # Проверяем, завершена ли игра, есть ли победитель или ничья когда все клетки заполнены
  def game_over?
    winner? || @board.flatten.none? { |cell| cell == ' ' }
  end

  # Проверяем, есть ли победитель (по строкам, столбцам или диагоналям)
  def winner?
    rows_win? || cols_win? || diagonals_win?
  end

  # Проверяем победу по строкам
  def rows_win?
    # Есть ли хотя одна строка с одинаковыми символами и не пустая
    @board.any? { |row| row.uniq.size == 1 && row.first != ' ' }
  end

  # Проверяем победу по столбцам
  def cols_win?
    # Меняем столбцы на строки и проверяем как строки
    @board.transpose.any? { |col| col.uniq.size == 1 && col.first != ' ' }
  end

  # Проверяем победу по диагоналям
  def diagonals_win?
    # Получаем диагонали
    left_diag = [@board[0][0], @board[1][1], @board[2][2]]
    right_diag = [@board[0][2], @board[1][1], @board[2][0]]
    # Проверяем как строки
    [left_diag, right_diag].any? { |diag| diag.uniq.size == 1 && diag.first != ' ' }
  end

  # Формируем сообщение о результате игры
  def result_message
    winner? ? "Игрок #{@current_player} победил!" : 'Ничья!'
  end
end

# Запуск игры
# TicTacToe.new.play
