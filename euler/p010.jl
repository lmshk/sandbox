primes(n) = @task let
  result = 0
  is_prime = fill(true, n)
  for i = 2:n
    is_prime[i] || continue
    produce(i)
    for j = (i * i):i:n
      is_prime[j] = false
    end
  end
end

result = sum(primes(1999999))
println(result)
