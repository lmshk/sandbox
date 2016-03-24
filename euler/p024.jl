function nthperm!(vector, permutation)
  permutation -= 1 # permutation 1 is the identity
  n = length(vector)
  for i in 1:n
    subpick, permutation = divrem(permutation, factorial(n - i))
    pick = subpick + i
    element = vector[pick]
    for j in pick:-1:(i + 1)
      vector[j] = vector[j - 1]
    end
    vector[i] = element
  end
  vector
end

nthperm!(collect(0:9), 1000000) |> join |> println
