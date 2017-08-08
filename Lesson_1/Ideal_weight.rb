puts "Как вас зовут?)"
  name = gets.chomp
puts "Какой твой рост?"
  heght = gets.chomp.to_i
  weght = (heght - 110)
if weght > 0
    puts "#{name} Твой идеальный вес #{weght}"
  else
    puts "#{name} у вас все в порядке с весом!"
end
