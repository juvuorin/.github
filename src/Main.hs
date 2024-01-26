
module Main where
--import Data.Time.Calendar.Month 
import Data.Time
--import Data.Time.Calendar.MonthDay
import Data.List (groupBy)
import Data.Time.Calendar
---------------------
-- src/MyBlog/Main.hs
import App
import Database

-- Extract the last day of Day
lastDayOfMonth date = do
      let (year, month, day) = toGregorian date
      let daysInMonth = gregorianMonthLength year month
      fromGregorian year month daysInMonth
    

daysRemainingUntilEndOfMonth date = 1+diffDays (lastDayOfMonth date) date   

daysPassedFromBeginningOfMonth date  = do
  let (_, _, days) = toGregorian date
  days

splitCost :: Double -> Day -> Day -> IO [(Day, Double)]
splitCost totalCost startDate endDate = do

    let totalDays = 1+diffDays endDate startDate 

    -- Calculate cost for the first and last month
    let startMonthCost = totalCost * (fromIntegral $ daysRemainingUntilEndOfMonth startDate) / (fromIntegral totalDays)
    let endMonthCost = totalCost * (fromIntegral $ daysPassedFromBeginningOfMonth endDate) / (fromIntegral totalDays)

    -- Extract year and month information from dates
    let (startYear, startMonth, _) = toGregorian startDate
    let (endYear, endMonth, _) = toGregorian endDate

    let months =  monthsBetween startDate endDate 
    print months
    -- create cost for each month
    let result =  map (\(month) -> do
          let nextMonthDay = addGregorianMonthsClip (fromIntegral month) startDate 
          let (year, month, day) = toGregorian nextMonthDay
          let daysInMonth = gregorianMonthLength year month
          (nextMonthDay, totalCost * (fromIntegral daysInMonth) / (fromIntegral totalDays))) [1..months-2]
    
    return $ [(startDate,startMonthCost)]++result++[(endDate,endMonthCost)]


-- Function to calculate the number of months between two dates
monthsBetween :: Day -> Day -> Int
monthsBetween startDate endDate =
  let startMonth = fromGregorian year month 1
      months = takeWhile (\m -> m <= endDate) $ iterate (addGregorianMonthsClip 1) startMonth
  in length months
  where
    (year, month, _) = toGregorian startDate


main :: IO ()
main = do
  
  let p'=monthsBetween (fromGregorian 2024 1 31)  (fromGregorian 2024 9 31)
  p <- splitCost 1000 (fromGregorian 2024 1 16)  (fromGregorian 2024 9 31)
  print p
  let u = round (sum (map snd p))
  print u