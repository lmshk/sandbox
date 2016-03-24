runnable_pattern = r"^p(\d+).jl$"
for file in readdir()
  m = match(runnable_pattern, file)
  if isa(m, RegexMatch)
    n = m.captures[1]
    println("$n: ", `julia $file` |> readstring |> chomp)
  end
end
