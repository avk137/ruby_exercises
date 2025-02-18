# frozen_string_literal: true

def stock_picker(prices)
  # Инициализируем переменные для хранения максимальной прибыли и индексов
  max_profit = 0
  best_days = []

  # Проходим по всем возможным парам (день покупки, день продажи)
  prices.each_with_index do |buy_price, buy_day|
    prices[buy_day + 1..].each_with_index do |sell_price, sell_day_offset|
      best_days, max_profit = update_best_days([buy_price, buy_day], sell_price, sell_day_offset, best_days, max_profit)
    end
  end

  best_days
end

# Обновляем максимальную прибыль и индексы дня покупки и продажи, если новая прибыль больше предыдущей
def update_best_days(buy_info, sell_price, sell_day_offset, best_days, max_profit)
  sell_day = buy_info[1] + sell_day_offset + 1
  profit = sell_price - buy_info[0]

  if profit > max_profit
    max_profit = profit
    best_days = [buy_info[1], sell_day]
  end

  [best_days, max_profit]
end

# Пример использования
# prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]
# stock_picker(prices)
# => [1, 4]
