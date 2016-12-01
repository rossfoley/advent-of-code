module Main where
factors a = a : [x | x <- [1..b], a `mod` x == 0] where b = a `quot` 2
presents a = sum (factors a) * 10
firsthouse a = if (presents a >= 29000000) then a else firsthouse (a + 1)
main = firsthouse 1