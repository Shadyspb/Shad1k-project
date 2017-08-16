alphabet = {}
vowels = 'aeiouy'

("a".."z").each.with_index(1) do |letters, index|
  if vowels.include?(letters)
    alphabet[letters] = index
  end
end

puts alphabet
