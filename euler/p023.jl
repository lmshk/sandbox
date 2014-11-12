function divisor_sum(n)
  result = 0
  for i = 1:sqrt(n)
    quotient, remainder = divrem(n, i)
    if remainder == 0
      result += i
      if quotient != i
        result += quotient
      end
    end
  end
  result - n
end

let
  limit = 28123
  is_abundant = falses(limit)
  for i = 1:limit
    if divisor_sum(i) > i
      is_abundant[i] = true
    end
  end

  result = 0
  for i = 1:limit
    is_abundant_sum = false
    for j = 1:(i - 1)
      if is_abundant[j] && is_abundant[i - j]
        is_abundant_sum = true
        break
      end
    end
    if !is_abundant_sum
      result += i
    end
  end

  println(result)
end
