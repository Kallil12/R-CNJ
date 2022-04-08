-- Challenge 1
-- Select the directors first and last names, the movie names and release dates
-- for all Chinese, Korean and Japanese movies.

SELECT first_name, last_name, movie_name, release_date
FROM movies
INNER JOIN directors ON directors.director_id = movies.director_id
WHERE movies.movie_lang IN ('Chinese','Korean','Japanese');

-- Select the movie names, release dates and international takings of all
-- English language movies

SELECT movie_name, release_date, international_takings
FROM movies
INNER JOIN movie_revenues ON movie_revenues.movie_id = movies.movie_id
WHERE movie_lang = 'English';

-- Select the movie names, domestic takings and international takings for all
-- movies with either missing domestic takings or missing international takings
-- and order the results by movie name

SELECT movie_name, domestic_takings, international_takings
FROM movies
INNER JOIN movie_revenues ON movies.movie_id = movie_revenues.movie_id
WHERE (domestic_takings IS NULL) OR (international_takings IS NULL)
ORDER BY movie_name;

-- Challenge 2
-- Use a left join to select the first and last names of all British directors
-- and the names and age certificates of the movies that they directed.

SELECT first_name, last_name, movie_name, age_certificate
FROM directors
LEFT JOIN movies ON directors.director_id = movies.director_id
WHERE nationality = 'British';

-- Count the number of movies that each director has directed.

SELECT d.first_name, d.last_name,  COUNT(movie_name)
FROM directors d
INNER JOIN movies mo ON d.director_id = mo.director_id
GROUP BY d.first_name, d.last_name
ORDER BY COUNT(movie_name) DESC;

-- Challenge 3
-- select the first and last names of all the actors who have starred in movies
-- directed by Wes Anderson


SELECT (ac.first_name ||' '|| ac.last_name) AS actor_name,
	   (d.first_name ||' '|| d.last_name) AS director_name
FROM actors ac
JOIN movies_actors ma ON ma.actor_id = ac.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
JOIN directors d ON d.director_id = mo.director_id
WHERE (d.first_name = 'Wes') AND (d.last_name = 'Anderson');


-- which director has the highest total domestic takings.


SELECT (d.first_name ||' '|| d.last_name) AS director_name,
		mo.movie_name,
	   (mr.domestic_takings + mr.international_takings) AS total_takings
FROM directors d
JOIN movies mo ON d.director_id = mo.director_id
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id
WHERE (mr.domestic_takings IS NOT NULL) AND (mr.international_takings IS NOT NULL)
ORDER BY (mr.domestic_takings + mr.international_takings) DESC
LIMIT 1;
