  puts "Введите число месяца"
  day = gets.chomp.to_i

  puts "Введите месяц"
  month = gets.chomp.to_i

  puts "Введите год"
  year = gets.chomp.to_i

  months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  if year % 4 == 0 && year % 100 !=0 || year % 400 == 0
    months[1] = 29
  end

  number = 0
  i = 0

  while i < (month - 1)
    number = number + months[i]
    i = i + 1
  end

  number = number + day

  puts "Порядковый номер даты =  #{number}"
