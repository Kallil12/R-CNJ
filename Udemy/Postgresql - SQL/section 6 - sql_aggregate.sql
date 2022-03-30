-- Challenge 1
-- count the number of actors born after the 1st of January 1970

SELECT COUNT(*)
FROM actors
WHERE date_of_birth < '1970-01-01';

-- what was the highest and lowest domestic takings for a movie?

SELECT MAX(domestic_takings) AS max_domestic_takings,
	     MIN(domestic_takings) AS min_domestic_takings
FROM movie_revenues;

-- what is the sum total movie length for movies rated 15?

SELECT SUM(movie_length) AS total_length_rating_15
FROM movies
WHERE age_certificate = '15';

-- how many Japanese directors are in the directors table?

SELECT COUNT(*)
FROM directors
WHERE nationality = 'Japanese';

-- what is the average movie length for Chinese movies?

SELECT ROUND(AVG(movie_length),2) AS avg_chinese_movie_lengh
FROM movies
WHERE movie_lang = 'Chinese';

-- Challenge 2
-- how many directors are there per nationality?

SELECT nationality, COUNT(nationality) AS total_nationality
FROM directors
GROUP BY nationality
ORDER BY nationality;

-- what is the sum total movie length for each age certificate and movie language
-- combination

SELECT movie_lang, age_certificate, SUM(movie_length) AS total_length
FROM movies
GROUP BY movie_lang, age_certificate
ORDER BY movie_lang, age_certificate;

-- return the movie languages which have a sum total movie length of over 500
-- minutes

SELECT movie_lang, SUM(movie_length) AS total_length
FROM movies
GROUP BY movie_lang
HAVING SUM(movie_length) > 500;
