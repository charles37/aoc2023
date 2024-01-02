import qualified Data.Vector as V
import Data.Vector ((!))
import Data.Char (isNumber)

import Control.Monad (forM)

for = flip map

--getNumSum :: Int -> Int -> Int -> Int -> V.Vector (V.Vector Int) -> Int
--getNumSum r c rows cols grid = sum $ for [r..r+2] $ \i ->
--                                        for [c..c+2] $ \j ->
--                                            if i > rows-1 || i < 0 || j > cols-1 || j < 0
--                                                then 0
--                                                else 


findAdjacent :: Int -> Int -> Int -> Int -> V.Vector (V.Vector Char) -> Bool
findAdjacent r c rows cols grid = foldl go False [(r-1,c-1), (r-1,c), (r-1,c+1), (r,c-1), (r,c+1), (r+1,c-1), (r+1,c), (r+1,c+1)]
    where go acc (r,c) = if r > rows-1 || r < 0 || c > cols-1 || c < 0 then acc else acc || isSymbol (grid V.! r V.! c)

go :: (Int, V.Vector (V.Vector Char), (Int,Int), String, (Bool,Bool))  -> (Int, Int) -> (Int, V.Vector (V.Vector Char), (Int,Int), String, (Bool, Bool))
go (count, grid, (rows,cols), s, (False, adjacency)) (r, c) = (newCount, grid, (rows,cols), newString, (readyToAccept, finalBool))
    where e = grid V.! r V.! c 
          isNum = isNumber e
          isnewRow = c == 0
          newCount = if isNum then count else (if adjacency then count + read s else count) 
          newString = if isNum then s ++ [e] else ""
          readyToAccept = not isNum
          finalBool = isNum && adjacencyFound
          adjacencyFound = findAdjacent r c rows cols grid 
go (count, grid, (rows,cols), s, (True, adjacency)) (r, c) = (count, grid, (rows,cols), newString, (not isNum, finalBool))
    where e =  grid V.! r V.! c 
          isNum = isNumber e 
          newString = if isNum then s ++ [e] else s
          finalBool = isNum && adjacencyFound
          adjacencyFound = findAdjacent r c rows cols grid 

isSymbol :: Char -> Bool
isSymbol c = c `elem` "*#$+"
 

main :: IO ()
main = do
    fileinput <- readFile "input3test.txt"
    let grid =  V.fromList . map V.fromList . lines $ fileinput
    print grid
    let rows = V.length grid
    let cols = V.length $ grid V.! 0 

    print rows
    print cols
    print grid

    --print $ grid ! 0 ! 0

    let allIndecies = [(x,y) | x <- [0..rows-1], y <-[0..cols-1]]
        nums = foldl go (0, grid, (rows,cols), "", (True,False)) allIndecies


    --forM [0..rows-1] $ \r -> 
    --            forM [0..cols-1] $ \c -> do
    --                let x = grid ! r ! c
    --                if isNumber x || x == '.' 
    --                    then pure 0 
    --                    else do 
    --                        let theSum = getNumSum r c rows cols grid
    --                        return theSum 

    print allIndecies 
    print nums
    





-- 467..114..
-- ...*......
-- ..35..633.
-- ......#...
-- 617*......
-- .....+.58.
-- ..592.....
-- ......755.
-- ...$.*....
-- .664.598..
