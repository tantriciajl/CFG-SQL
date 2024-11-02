USE WORLD;

SELECT * FROM COUNTRYLANGUAGE;

SELECT
COUNT(C.LANGUAGE),
C.COUNTRYCODE
FROM COUNTRYLANGUAGE C
GROUP BY C.LANGUAGE;

SELECT * FROM COUNTRYLANGUAGE;

/* number of languages spoken in each country or in each country code */
SELECT
COUNT(DISTINCT C.LANGUAGE), C.COUNTRYCODE
FROM COUNTRYLANGUAGE C
GROUP BY C.COUNTRYCODE;

SELECT * FROM COUNTRYLANGUAGE;

SELECT
COUNT(DISTINCT C.LANGUAGE), -- count of unique languages
C.COUNTRYCODE --  number of languages per country (distinguished by country code)
FROM COUNTRYLANGUAGE C
GROUP BY C.COUNTRYCODE -- number of languages appears per country
HAVING COUNT(DISTINCT C.LANGUAGE) >= 2 -- only show countries that speak more than two languages in results table


