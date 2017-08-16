puts "Для остановки программы введите стоп"
product = {}

loop do
  puts 'Введите название товара:'
  name = gets.chomp
  if name == 'стоп'
   break
  end
  puts 'Введите цену:'
  price = gets.chomp.to_f

  puts 'Введите количество товара:'
  quantity = gets.chomp.to_f

  product[name] = { price => quantity }
end

total = 0

product.each do |product, description|
print "#{product}, "
  description.each do |price, quantity|
    sum = price * quantity
    print "Кол-во #{quantity}, Цена за товар #{price}, Всего: #{sum.round(2)} \n"
    total = total + sum
  end
end

puts "Общая сумма покупки: #{total.round(2)}"
