puts "Введите 1 коэффициент"
a = gets.chomp.to_f

puts "Введите 2 коэффициент"
b = gets.chomp.to_f

puts "Введите 3 коэффициент"
c = gets.chomp.to_f

d = b ** 2 - (4 * a * c)

if d < 0
  puts "Корней нет"
elsif d == 0
  puts "Дискриминант = #{d.round}. Корень равен 0"
else
  qu = Math.sqrt(d)
  x1 = ((-b + qu) / 2 * a).round(3)
  x2 = ((-b - qu) / 2 * a).round(3)
  puts "Дискриминант = #{d}, 1 корень = #{x1}, 2 корень = #{x2}"
end
