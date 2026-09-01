-- CREATING DATABASE
CREATE DATABASE energydb; 
USE energydb;

-- CREATING TABLES
-- 1.Country Table
CREATE TABLE country (
CID VARCHAR(10) PRIMARY KEY,
Country VARCHAR(100) UNIQUE
);

-- 2.Consumption Table
CREATE TABLE consumption (
country VARCHAR(100),
energy VARCHAR(50),
year INT,
consumption DOUBLE
);

-- 3. Production Table
CREATE TABLE production (
country VARCHAR(100),
energy VARCHAR(50),
year INT,
production DOUBLE
);

-- 4. Emission Table
CREATE TABLE emission_3 (
country VARCHAR(100),
energy_type VARCHAR(50),
year INT,
emission DOUBLE,
per_capita_emission DOUBLE
);

-- 5. GDP Table
CREATE TABLE gdp_3 (
Country VARCHAR(100),
year INT,
value DOUBLE
);

-- 6. Population Table
CREATE TABLE population (
countries VARCHAR(100),
year INT,
value DOUBLE
);

-- To check all the 6 created tables are presented in the  energydb database
SHOW TABLES;

-- After Importing CSV files
-- Verify Data Imported
SELECT * FROM country;
SELECT * FROM consumption;
SELECT * FROM production;
SELECT * FROM emission_3;
SELECT * FROM gdp_3;
SELECT * FROM population;

-- Create Relationsips
-- Consumption
ALTER TABLE consumption
ADD FOREIGN KEY(country)
REFERENCES country(Country);

-- Production
ALTER TABLE production
ADD FOREIGN KEY(country)
REFERENCES country(Country);

-- Emission
ALTER TABLE emission_3
ADD FOREIGN KEY(country)
REFERENCES country(Country);

-- GDP
ALTER TABLE gdp_3
ADD FOREIGN KEY(country)
REFERENCES country(Country);

-- Population
ALTER TABLE population
ADD FOREIGN KEY(countries)
REFERENCES country(Country);

-- DATA CLEANING
-- CHECK NULL VALUES
SELECT * FROM consumption
WHERE consumption IS NULL;

SELECT * FROM production
WHERE production IS NULL;

SELECT * FROM gdp_3
WHERE value IS NULL;

SELECT * FROM population
WHERE value IS NULL;

-- Data Analysis Questions  
-- General & Comparative Analysis
-- 1. What is the total emission per country for the most recent year available?
SELECT country,
       SUM(emission) AS total_emission
FROM emission_3
WHERE year = (
      SELECT MAX(year)
      FROM emission_3
)
GROUP BY country
ORDER BY total_emission DESC;

-- 2. What are the top 5 countries by GDP in the most recent year?
SELECT Country,
       Value AS GDP
FROM gdp_3
WHERE year = (
      SELECT MAX(year)
      FROM gdp_3
)
ORDER BY GDP DESC
LIMIT 5;

-- 3. Compare energy production and consumption by country and year.
SELECT p.country,
	   p.year,
       SUM(p.production) AS total_production,
       SUM(c.consumption) AS total_consumption
FROM production p 
JOIN consumption c
ON p.country = c.country
AND p.year = c.year
GROUP BY p.country, p.year;

-- 4. Which energy types contribute most to emissions?
SELECT energy_type,
	SUM(emission) AS total_emission
FROM emission_3
GROUP BY energy_type
ORDER BY total_emission DESC;

-- Trend Analysis Over Time
-- 5. How have global emissions changed year over year?
SELECT year,
	SUM(emission) AS global_emission
FROM emission_3
GROUP BY year
ORDER BY year;

-- 6. What is the trend in GDP for each country over the given years?
SELECT Country,
		year,
        value
FROM gdp_3
ORDER BY Country,year;

-- Performs analysis using LAG() window function
-- LAG() - How much GDP changed compared to the previous year : Current GDP - Previous Year's GDP
SELECT Country,
       year,
       Value,
       Value -
       LAG(Value)
       OVER(PARTITION BY Country ORDER BY year)
       AS GDP_Change
FROM gdp_3;

-- 7. How has population growth affected total emissions in each country?
SELECT p.countries,
       p.year,
       p.Value AS population,
       SUM(e.emission) AS total_emission
FROM population p
JOIN emission_3 e
ON p.countries = e.country
AND p.year = e.year
GROUP BY p.countries, p.year, p.Value
ORDER BY p.countries, p.year;

-- 8.Has energy consumption increased or decreased over the years for major economies?
SELECT country,
       year,
       SUM(consumption) AS total_consumption,
       SUM(consumption)
       - LAG(SUM(consumption))
       OVER(PARTITION BY country ORDER BY year)
       AS yearly_change
FROM consumption
GROUP BY country, year
ORDER BY country, year;

-- 9.What is the average yearly change in emissions per capita for each country?
SELECT country,
       AVG(change_value) AS avg_yearly_change
FROM
(
      SELECT country,
             year,
             per_capita_emission -
             LAG(per_capita_emission)
             OVER(PARTITION BY country ORDER BY year)
             AS change_value
      FROM emission_3
) x
GROUP BY country;

-- 10. What is the emission-to-GDP ratio for each country by year?
SELECT e.country,
       e.year,
       SUM(e.emission)/g.Value
       AS emission_gdp_ratio
FROM emission_3 e
JOIN gdp_3 g
ON e.country=g.Country
AND e.year=g.year
GROUP BY e.country,e.year,g.Value
ORDER BY e.country,e.year;

-- 11. What is the energy consumption per capita for each country over the last decade?
SELECT c.country,
       c.year,
       SUM(c.consumption)/p.Value
       AS consumption_per_capita
FROM consumption c
JOIN population p
ON c.country=p.countries
AND c.year=p.year
WHERE c.year >=
(
SELECT MAX(year)-9
FROM consumption
)
GROUP BY c.country,c.year,p.Value
ORDER BY c.country,c.year;

-- 12.How does energy production per capita vary across countries?
SELECT pr.country,
       pr.year,
       SUM(pr.production)/p.Value
       AS production_per_capita
FROM production pr
JOIN population p
ON pr.country=p.countries
AND pr.year=p.year
GROUP BY pr.country,pr.year,p.Value
ORDER BY pr.country,pr.year;

-- 13. Which countries have the highest energy consumption relative to GDP?
SELECT c.country,
       c.year,
       SUM(c.consumption)/g.Value
       AS consumption_gdp_ratio
FROM consumption c
JOIN gdp_3 g
ON c.country=g.Country
AND c.year=g.year
GROUP BY c.country,c.year,g.Value
ORDER BY consumption_gdp_ratio DESC;

-- 14.What is the correlation between GDP growth and energy production growth?
SELECT Country,
       year,
       Value,
       Value - LAG(Value) OVER(PARTITION BY Country ORDER BY year) AS GDP_Growth
FROM gdp_3;

SELECT country,
       year,
       SUM(production) AS Total_Production
FROM production
GROUP BY country, year
ORDER BY country, year;

SELECT country,
       year,
       SUM(production) AS Total_Production
FROM production
GROUP BY country, year
ORDER BY country, year;

-- 15. What are the top 10 countries by population and how do their emissions compare?
SELECT p.countries,
       p.Value AS population,
       SUM(e.emission) AS total_emission
FROM population p
JOIN emission_3 e
ON p.countries=e.country
AND p.year=e.year
WHERE p.year=
(
SELECT MAX(year)
FROM population
)
GROUP BY p.countries,p.Value
ORDER BY population DESC
LIMIT 10;
 
-- 15.1. What are the top 10 countries by population
SELECT
countries,
Value
FROM population
WHERE year=
(
SELECT MAX(year)
FROM population
)
ORDER BY Value DESC
LIMIT 10;

-- 16.Which countries have improved (reduced) their per capita emissions the most over the last decade?
SELECT country,
       MAX(per_capita_emission)
       -
       MIN(per_capita_emission)
       AS reduction
FROM emission_3
WHERE year >=
(
SELECT MAX(year)-9
FROM emission_3
)
GROUP BY country
ORDER BY reduction DESC;

-- 17.What is the global share (%) of emissions by country?
SELECT country,
       SUM(emission)*100/
       (
         SELECT SUM(emission)
         FROM emission_3
       )
       AS global_share
FROM emission_3
GROUP BY country
ORDER BY global_share DESC;

-- 18.What is the global average GDP, emission, and population by year? 
SELECT g.year,
       AVG(g.Value) AS avg_gdp,
       AVG(e.emission) AS avg_emission,
       AVG(p.Value) AS avg_population
FROM gdp_3 g
JOIN emission_3 e
ON g.Country=e.country
AND g.year=e.year
JOIN population p
ON g.Country=p.countries
AND g.year=p.year
GROUP BY g.year
ORDER BY g.year;






















































