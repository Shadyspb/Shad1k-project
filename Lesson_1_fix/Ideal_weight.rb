puts "Как вас зовут?)"
name = gets.chomp

puts "Какой твой рост?"
height = gets.chomp.to_i

weight = heght - 110

if weght > 0
  puts "#{name} Твой идеальный вес #{weight}"
else
  puts "#{name} у вас все в порядке с весом!"
end
