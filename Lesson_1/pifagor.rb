puts "Введите 1 сторону треугольника"
a = gets.chomp.to_f
puts "Введите 2 сторону треугольника"
b = gets.chomp.to_f
puts "Введите 3 сторону треугольника"
c = gets.chomp.to_f

if a > b && a > c
  hypotenuse = a
  katet1 = b
  katet2 = c
elsif b > a && b > c
  hypotenuse = b
  katet1 = a
  katet2 = c
else
  hypotenuse = c
  katet1 = a
  katet2 = b
end

if hypotenuse**2 == katet1**2 + katet2**2
puts "Прямоугольный"
elsif a == b && b != c || b == c && c != a
puts "Равнобедренный"
elsif a == b && b == c && a == c
puts "Равнобедренный и Равносторонний"
else
puts "Разносторонний"
end
