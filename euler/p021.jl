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

function is_amicable(n)
  m = divisor_sum(n)
  return m != n == divisor_sum(m)
end

sum(n -> int(is_amicable(n)) * n, 1:9999) |> println
