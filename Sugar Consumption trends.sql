Create Database Sugar_Consumption_Trends;
Use Sugar_Consumption_Trends;

CREATE TABLE SugarConsumption (
    Country VARCHAR(100),
    Year INT,
    Country_Code VARCHAR(10),
    Continent VARCHAR(50),
    Region VARCHAR(100),
    Population BIGINT,
    GDP_Per_Capita FLOAT,
    Per_Capita_Sugar_Consumption FLOAT,
    Total_Sugar_Consumption FLOAT,
    Sugar_From_Sugarcane FLOAT,
    Sugar_From_Beet FLOAT,
    Sugar_From_HFCS FLOAT,
    Processed_Food_Consumption FLOAT,
    Avg_Daily_Sugar_Intake FLOAT,
    Diabetes_Prevalence FLOAT,
    Obesity_Rate FLOAT,
    Sugar_Imports FLOAT,
    Sugar_Exports FLOAT,
    Avg_Retail_Price_Per_Kg FLOAT,
    Gov_Tax INT,
    Gov_Subsidies INT,
    Education_Campaign INT,
    Urbanization_Rate FLOAT,
    Climate_Conditions INT,
    Sugarcane_Production_Yield FLOAT
);

						#  General Data Exploration
# 1. List all distinct countries in the dataset
SELECT DISTINCT
    Country
FROM
    SugarConsumption;

#2. Show the data for India from 2000 to 2020
SELECT 
    *
FROM
    SugarConsumption
WHERE
    Country = 'India'
        AND (Year BETWEEN 2000 AND 2020);

#3. Find the top 10 countries by total sugar consumption in 2020
SELECT 
    Country,
    ROUND(SUM(Total_Sugar_Consumption), 2) AS 'Total Sugar Consumption'
FROM
    SugarConsumption
WHERE
    Year = 2020
GROUP BY country
ORDER BY SUM(Total_Sugar_Consumption) DESC
LIMIT 10;

#4. Find the average per capita sugar consumption for each continent.
SELECT 
    Continent,
    ROUND(AVG(Per_Capita_Sugar_Consumption), 2) AS 'Per Capita Sugar Consumption'
FROM
    Sugarconsumption
GROUP BY Continent;

#5. Show the trend of average obesity rate globally from 1960 to 2023.
SELECT 
    YEAR, ROUND(AVG(Obesity_Rate), 2) AS 'Avg Obesity'
FROM
    Sugarconsumption
GROUP BY Year
ORDER BY Year;

						#Aggregations & Grouping
#6. Find the country with the highest GDP in 2020 per capita .
SELECT 
    Country, MAX(GDP_Per_Capita) AS 'Max GDP Per Capita'
FROM
    Sugarconsumption
WHERE
    Year = 2020
GROUP BY Country
ORDER BY MAX(GDP_Per_Capita) DESC;

#7. Calculate the average diabetes prevalence for each region.
SELECT 
    Region,
    ROUND(AVG(Diabetes_Prevalence), 2) AS 'AVG Diabetes Prevalence'
FROM
    Sugarconsumption
GROUP BY Region;

#8. Find the top 5 countries with the highest sugarcane production yield in 2023.
SELECT 
    Country,
    MAX(Sugarcane_Production_Yield) AS 'Max Sugarcane Production'
FROM
    Sugarconsumption
WHERE
    Year = 2023
GROUP BY Country
ORDER BY MAX(Sugarcane_Production_Yield) DESC
LIMIT 5;

#9. Compare total sugar consumption between developed and developing regions (assume region column groups them).
SELECT 
    ROUND(SUM(Total_Sugar_Consumption), 2) AS 'Total Sugar Consumption',
    CASE
        WHEN
            Region IN ('North America' , 'Western Europe',
                'Australia & New Zealand')
        THEN
            'Developed'
        ELSE 'Developing'
    END AS Development_Status
FROM
    SugarConsumption
GROUP BY Development_Status;

#10. Compare processed food consumption and obesity rate by country and year.
SELECT 
    Year,
    ROUND(SUM(Processed_Food_Consumption), 2) AS 'Sum Processes Food',
    ROUND(SUM(Obesity_Rate), 2) AS 'Sum Obesity Rate'
FROM
    Sugarconsumption
GROUP BY YEAR
ORDER BY Year;

						#Policy Analysis
#11. Find countries that implemented sugar tax and show how their sugar consumption changed before and after
SELECT 
    country, gov_tax, ROUND(AVG(Total_Sugar_Consumption), 2)
FROM
    sugarconsumption
GROUP BY country , Gov_Tax
ORDER BY country;

#12. Compare average sugar consumption between countries with and without government subsidies.
SELECT 
    ROUND(AVG(Per_Capita_Sugar_Consumption), 2) AS Avg_Sugar_Consumption,
    CASE
        WHEN Gov_Subsidies > 0 THEN 'With_Subsidies'
        ELSE 'Without_Subsidies'
    END AS Subsidy_Status
FROM
    SugarConsumption
GROUP BY Subsidy_Status;

								# Agriculture & Climate
#13. Find the average climate condition per region and its relation to sugarcane production.
SELECT 
    region,
    ROUND(AVG(Climate_Conditions), 2) AS Avg_Climate,
    ROUND(AVG(Sugarcane_Production_Yield), 2) AS Avg_sugar
FROM
    sugarconsumption
GROUP BY region
ORDER BY ROUND(AVG(Climate_Conditions), 2);

#14. List of country where export is higher than import till now
SELECT 
    country,
    ROUND(SUM(Sugar_Exports), 2),
    ROUND(SUM(Sugar_Imports), 2)
FROM
    sugarconsumption
GROUP BY country
HAVING SUM(Sugar_Exports) > SUM(Sugar_Imports);