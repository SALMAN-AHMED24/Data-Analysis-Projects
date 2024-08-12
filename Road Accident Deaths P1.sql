-- ROAD ACCIDENT DEATHS PER YEAR IN THE WHOLE WORLD

DROP TABLE IF EXISTS #totaldeathsperyear
CREATE TABLE #totaldeathsperyear
(Country nvarchar(250),
Year int,
totaldeathsinthisyear int
)

INSERT INTO #totaldeathsperyear
SELECT Country, Year, (SeventyPlus + FiFtyToSixty + FifteenToFourtyNine + FiveToFourteen + UnderFive) as totaldeathsinthisyear
FROM Portfolio1..road_accident_deaths
WHERE Country = 'World'

SELECT *
FROM #totaldeathsperyear

-- TOTAL DEATHS IN THE PERIOD OF (1990-2019)

SELECT Country, Year, totaldeathsinthisyear,
SUM(totaldeathsinthisyear) OVER (PARTITION BY Country ORDER BY Year) as totaldeaths
FROM #totaldeathsperyear
GROUP BY Country, Year, totaldeathsinthisyear

SELECT SUM(totaldeathsinthisyear) as totaldeathsrom1990to2019
FROM #totaldeathsperyear

-- DEATH PARCENTAGE PER YEAR ACCORDING TO THE AGE

SELECT road.Country, road.Year, SeventyPlus, FiftyToSixty, FifteenToFourtyNine, FiveToFourteen, UnderFive, totaldeathsinthisyear,
(SeventyPlus/totaldeathsinthisyear)*100 as parcentageofseventyplus,
(FiftyToSixty/totaldeathsinthisyear)*100 as parcentageofFiftyToSixty,
(FifteenToFourtyNine/totaldeathsinthisyear)*100 as parcentageofFifteenToFourtyNine,
(FiveToFourteen/totaldeathsinthisyear)*100 as parcentageofFiveToFourteen,
(UnderFive/totaldeathsinthisyear)*100 as parcentageofUnderFive
FROM #totaldeathsperyear as total
Inner Join Portfolio1..road_accident_deaths as road
	ON total.Country = road.Country AND total.Year = road.Year


-- YEAR WITH THE HIGHEST DEATHS

SELECT *
FROM #totaldeathsperyear
ORDER BY totaldeathsinthisyear DESC



-- COUNTRY WITH THE HIGHEST ROAD ACCIDENT DEATHS

DROP TABLE IF EXISTS #totaldeathspartitionbycountry
CREATE TABLE #totaldeathspartitionbycountry
(Country nvarchar(250),
Year int,
totaldeathsinthisyear int
)

INSERT INTO #totaldeathspartitionbycountry
SELECT Country, Year, (SeventyPlus + FiFtyToSixty + FifteenToFourtyNine + FiveToFourteen + UnderFive) as totaldeathsinthisyear
FROM Portfolio1..road_accident_deaths
WHERE Country <> 'World'

SELECT *
FROM #totaldeathspartitionbycountry
WHERE Country <> 'G20' AND Country <> 'World Bank Upper Middle Income' AND Country <> 'World Bank Lower Middle Income'
AND Country <> 'East Asia & Pacific (WB)'  AND Country <> 'Western Pacific Region (WHO)' 
AND Country <> 'South-East Asia Region (WHO)'
ORDER BY totaldeathsinthisyear DESC


-- ROAD ACCIDENT DEATHS ACORDING TO THE USA(PER YEAR)

SELECT * 
FROM #totaldeathspartitionbycountry
WHERE Country = 'United States'

-- YEAR WITH THE HIGHEST DEATHS(USA)

SELECT * 
FROM #totaldeathspartitionbycountry
WHERE Country = 'United States'
ORDER BY totaldeathsinthisyear DESC

-- TOTAL DEATHS IN THE USA(1990-2019)

SELECT *,
SUM(totaldeathsinthisyear) OVER (PARTITION BY Country ORDER BY Year) as totaldeaths
FROM #totaldeathspartitionbycountry
WHERE Country = 'United States'

SELECT SUM(totaldeathsinthisyear) as totaldeathsfrom1990to2019
FROM #totaldeathspartitionbycountry
WHERE Country = 'United States'
