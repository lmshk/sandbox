function is_palindrome(n)
  s = string(n)
  s == reverse(s)
end

palindromes(n) = @task let
  for i = 1:n, j = i:n
    p = i * j
    is_palindrome(p) && produce(p)
  end
end

result = maximum(palindromes(999))
println(result)
