const letters = [
  0 => 0, # <- to simplify the code later on
  1 => 3,
  2 => 3,
  3 => 5,
  4 => 4,
  5 => 4,
  6 => 3,
  7 => 5,
  8 => 5,
  9 => 4,
  10 => 3,
  11 => 6,
  12 => 6,
  13 => 8,
  14 => 8,
  15 => 7,
  16 => 7,
  17 => 9,
  18 => 8,
  19 => 8,
  20 => 6,
  30 => 6,
  40 => 5,
  50 => 5,
  60 => 5,
  70 => 7,
  80 => 6,
  90 => 6,
  1000 => 11
]

const hundred = 7
const and = 3

function count(n)
  if n < 20
    return letters[n]
  elseif n < 100
    last = n % 10
    return letters[n - last] + count(last)
  elseif n < 1000
    part2 = count(n % 100)
    if part2 > 0
      part2 += and
    end
    return letters[div(n, 100)] + hundred + part2
  else
    return 11 # one thousand
  end
end

println(sum(count, 1:1000))
