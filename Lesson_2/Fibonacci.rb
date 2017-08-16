fib = [0,1]

while (num = fib[-2] + fib.last) < 100 do
  fib << num
end

puts fib
