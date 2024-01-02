module Main

import Data.List

-- Define a function to map spelled-out numbers to their numeric values
digitValue : List Char -> Maybe Nat
digitValue s = case s of
  "one"   => Just 1
  "two"   => Just 2
  "three" => Just 3
  "four"  => Just 4
  "five"  => Just 5
  "six"   => Just 6
  "seven" => Just 7
  "eight" => Just 8
  "nine"  => Just 9
  _       => Nothing

digitToInt : Char -> Nat
digitToInt c = case c of
  '0' => 0
  '1' => 1
  '2' => 2
  '3' => 3
  '4' => 4
  '5' => 5
  '6' => 6
  '7' => 7
  '8' => 8
  '9' => 9
  _   => 0


-- A helper function to parse a digit from a string
parseDigit : List Char -> Maybe Nat
parseDigit str = case str of
  (c :: _) => if isDigit c then Just (cast (digitToInt c)) else digitValue str
  _ => Nothing

-- Extract the first and last 'digit' from a string
extractDigits : String -> Maybe (Nat, Nat)
extractDigits str = do
  let wordsAndDigits = words str
  firstDigit <- parseDigit (head wordsAndDigits)
  lastDigit <- parseDigit (last wordsAndDigits)
  return (firstDigit, lastDigit)

-- Process each line to calculate the sum
calculateSum : List String -> Nat
calculateSum lines = sum $ catMaybes $ map extractDigits lines


-- read from input1.txt and print the result
main : IO ()
main = do
  input <- readFile "input1.txt"
  let lines = splitOn "\n" input
  let result = calculateSum lines
  putStrLn $ "The sum is " ++ show result

