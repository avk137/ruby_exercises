# frozen_string_literal: true

# Класс игры Mastermind
class Mastermind
  COLORS = %w[R G B Y O P].freeze

  def initialize
    @secret_code = generate_code
    @attempts = 12
  end

  def play
    puts "Добро пожаловать в Mastermind! Угадайте комбинацию из 4 цветов: #{COLORS.join(', ')}."
    @attempts.times do |i|
      puts "\nПопытка #{i + 1}/#{@attempts}:"
      guess = player_guess
      return puts 'Ура! Вы угадали секретный код.' if guess == @secret_code

      give_feedback(guess)
    end
    puts "К сожалению, попытки закончились. Секретный код был: #{@secret_code.join}."
  end

  private

  def generate_code
    COLORS.sample(4)
  end

  def player_guess
    loop do
      print 'Введите 4 цвета (например, RGBY): '
      input = gets.chomp.upcase.chars
      return input if valid_guess?(input)

      puts "Неверный ввод. Используйте только #{COLORS.join(', ')}."
    end
  end

  def valid_guess?(guess)
    guess.size == 4 && colors_valid?(guess)
  end

  def colors_valid?(guess)
    guess.all? { |color| COLORS.include?(color) }
  end

  def give_feedback(guess)
    exact = exact_matches(guess)
    total = total_matches(guess)
    puts "Точно угадано: #{exact}. Цвета на месте: #{total - exact}."
  end

  def exact_matches(guess)
    guess.zip(@secret_code).count { |g, s| g == s }
  end

  def total_matches(guess)
    guess.uniq.sum { |color| [guess.count(color), @secret_code.count(color)].min }
  end
end

# Запуск игры
# Mastermind.new.play
