puts "Как вас зовут?)"
name = gets.chomp

puts "Какой твой рост?"
height = gets.chomp.to_i

weight = height - 110

if weight > 0
  puts "#{name} Твой идеальный вес #{weight}"
else
  puts "#{name} у вас все в порядке с весом!"
end
