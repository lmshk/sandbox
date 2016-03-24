prime_bound(n) = n <= 5 ? 11 : ceil(Integer, n * (log(n) + log(log(n))))

function prime(n)
  # Sieve of Erastothenes
  size = prime_bound(n)
  is_prime = fill(true, size)
  prime_index = 0
  for i = 2:size
    is_prime[i] || continue
    prime_index += 1
    if prime_index >= n; return i end
    for j = (i*i:i:size)
      is_prime[j] = false
    end
  end
end

println(prime(10001))
