b = 99
c = 99

if a != 0
  b = 109900
  c = 126900
end

# Loop
while g != 0
  f = 1
  d = 2

  while g != 0
    e = 2
    f = 0 if b.is_even?
    while g != 0
      g = (d * e) - b
      if g == 0
        f = 0
      end
      e += 1
      g = e - b
    end
    d += 1
    g = d - b
  end
  # At this point:
  # d = b
  # g = 0

  if f == 0 # occurs when b is even
    h += 1
  end

  g = b - c
  b += 17
end
