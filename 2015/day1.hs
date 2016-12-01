parenValue :: Char -> Int
parenValue x
  | x == '(' = 1
  | x == ')' = -1
  | otherwise = 0

currentFloor :: String -> Int
currentFloor = foldl sumParen 0
  where sumParen acc x = acc + parenValue x

part1 = currentFloor

part2 :: String -> Int
part2 input = length $ foldl untilBasement "" input
  where untilBasement acc x = if (currentFloor acc) >= 0
                              then x : acc
                              else acc


main = do
  input <- readFile "day1-input.txt"
  putStrLn $ "Part 1: " ++ show (part1 input)
  putStrLn $ "Part 2: " ++ show (part2 input)
