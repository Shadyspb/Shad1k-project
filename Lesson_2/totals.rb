puts "Для остановки программы введите стоп"
product = {}

loop do
  puts 'Введите название товара:'
  name = gets.chomp
  break if name == 'стоп'

  puts 'Введите цену:'
  price = gets.to_f

  puts 'Введите количество товара:'
  quantity = gets.to_f

  product[name] = { price: price , quantity: quantity }
end

total = 0

product.each do |product, description|
sum = description[:price] * description[:quantity]
print "#{product},  Кол-во:  #{description[:quantity]}, Цена за товар: #{description[:price]}, Всего: #{sum.round(2)} \n"
total = total + sum
end

puts "Общая сумма покупки: #{total.round(2)}"
