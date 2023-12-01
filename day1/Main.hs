import Data.Char (digitToInt, isNumber)

getNums ::  String -> [Int]
getNums [] = []
getNums ('o':'n':'e':xs) = 1 : getNums ('e':xs)
getNums ('t':'w':'o':xs) = 2 : getNums ('o':xs)
getNums ('t':'h':'r':'e':'e':xs) = 3 : getNums ('e':xs)
getNums ('f':'o':'u':'r':xs) = 4 : getNums xs
getNums ('f':'i':'v':'e':xs) = 5 : getNums ('e':xs)
getNums ('s':'i':'x':xs) = 6 : getNums xs
getNums ('s':'e':'v':'e':'n':xs) = 7 : getNums ('n':xs)
getNums ('e':'i':'g':'h':'t':xs) = 8 : getNums ('t':xs)
getNums ('n':'i':'n':'e':xs) = 9 : getNums ('e':xs)
getNums (x:xs) = if isNumber x then digitToInt x : getNums xs else getNums xs


main :: IO ()
main = do
    inputFile <- readFile "input1part2.txt"
    print $ sum $ map ((\x -> head x * 10 + last x) . getNums) $ words inputFile




--main :: IO ()
--main = do
--    inputFile <- readFile "input1part2.txt"
--    let wordsList = words inputFile 
--    let numsList = map getNums wordsList
--    let numbers = map (\x -> head x * 10 + last x) numsList
--    let result = sum numbers
--    print result



--main :: IO ()
--main = do
--    inputFile <- readFile "input1.txt"
--    let wordsList = words inputFile
--    let numsList = map (filter isNumber) wordsList
--    let numbers = map (\x -> read (head x: last x:"") :: Int) numsList
--    let result = foldr (+) 0 numbers 
--    print result
--
