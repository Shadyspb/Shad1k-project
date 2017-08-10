puts "Введите 1 коэффициент"
a = gets.chomp.to_f

puts "Введите 2 коэффициент"
b = gets.chomp.to_f

puts "Введите 3 коэффициент"
c = gets.chomp.to_f

d = b ** 2 - (4 * a * c)

qu = Math.sqrt(d)

if d > 0
  x1 = ((-b + qu) / 2 * a).round(3)
  x2 = ((-b - qu) / 2 * a).round(3)
  puts "Дискриминант = #{d}, 1 корень = #{x1}, 2 корень = #{x2}"
elsif d == 0
  x1 = -b / (2 * a)
  puts "Дискриминант = #{d}, 1 корень = #{x1}"
else
  puts "Корней нет"
end
