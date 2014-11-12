is_leap(year) = return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)

function day_count(year, month)
  if month in [1, 3, 5, 7, 8, 10, 12]
    return 31
  elseif month in [4, 6, 9, 11]
    return 30
  elseif is_leap(year)
    return 29
  else
    return 28
  end
end

let
  weekday = 1 # Monday on 1900-01-01
  weekday += sum(x -> day_count(1900, x), 1:12) # Skip to 1901-01-01
  weekday %= 7

  first_of_month_sundays = 0
  for year = (1901:2000), month = (1:12)
    if weekday == 0
      first_of_month_sundays += 1
    end
    weekday += day_count(year, month)
    weekday %= 7
  end

  println(first_of_month_sundays)
end
