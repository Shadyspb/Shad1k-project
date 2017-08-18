alphabet = {}
vowels = 'aeiouy'

("a".."z").each.with_index(1) do |letter, index|
  alphabet[letter] = index if vowels.include?(letter)
end

puts alphabet
