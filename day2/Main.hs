import Data.Char (isNumber, digitToInt)
import Data.List.Split (splitOn)
import Debug.Trace


type Bag = (Int, [(Int, Int, Int)])

transformLine :: String -> Bag
transformLine [] = (0, [])
transformLine (x:xs) = case takeWhile isNumber (x:xs) of
    [] -> transformLine xs
    num -> (read num :: Int, map (transformPicks 0 (0,0,0)) (splitOn ";" xs))

    -- | isNumber x = (digitToInt x, map (transformPicks 0 (0,0,0)) (splitOn ";" xs))
    -- | otherwise = (0, [])

transformPicks :: Int -> (Int,Int,Int) -> String -> (Int,Int,Int) 
transformPicks _ picks [] = picks
transformPicks n (r,g,b) ('r':'e':'d':xs) = transformPicks 0 (r + n, g, b) xs
transformPicks n (r,g,b) ('g':'r':'e':'e':'n':xs) = transformPicks 0 (r, g + n, b) xs
transformPicks n (r,g,b) ('b':'l':'u':'e':xs) = transformPicks 0 (r, g, b + n) xs
transformPicks n p (x:xs) = case takeWhile isNumber (x:xs) of
                                [] -> transformPicks n p xs 
                                num -> transformPicks (read num :: Int) p (drop (length num) (x:xs)) 

doCheck :: Int -> Bag -> Int
doCheck n (idNum, xs) = if all rgbGood xs then idNum + n else n

doCheck2 :: Int -> Bag -> Int
doCheck2 n (idNum, xs) = calculatePowerNum xs + n

calculatePowerNum = (\(x,y,z) -> x * y * z) .  foldl (\(a,b,c) (x,y,z) -> (max a x, max b y, max c z)) (0,0,0) 


rgbGood :: (Int,Int,Int) -> Bool
rgbGood (r,g,b) = r <= 12 && g <= 13 && b <= 14


main :: IO ()
main = do
    inputfile <- readFile "input2.txt"
    let splitFile = lines inputfile
    let transformedArray = map transformLine splitFile
    print transformedArray
    --let ans = foldl doCheck 0 transformedArray
    let ans = foldl doCheck2 0 transformedArray

    print ans

--Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
--Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
--Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
--Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
--Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
