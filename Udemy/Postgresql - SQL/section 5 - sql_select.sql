-- Challenge 1
-- select the movie_name and release_date of every movie

SELECT movie_name, release_date
FROM movies;

-- select the first and last names of all American directors

SELECT first_name, last_name
FROM directors
WHERE nationality = 'American';

-- select all male actors born after the 1st of January 1970

SELECT *
FROM actors
WHERE gender = 'M' AND
	    date_of_birth > '1970-01-01';

-- select the names of all movies which are over 90 minutes long and movie
-- language is English

SELECT movie_name
FROM movies
WHERE movie_lang = 'English' AND
	    movie_length > 90;

-- Challenge 2
-- select the movie names and movie language of all movies with English, Spanish
-- or Korean language

SELECT movie_name, movie_lang
FROM movies
WHERE movie_lang IN ('English', 'Spanish', 'Korean');

-- select the first and last names of the actors whose last name begins with M
-- and were born between 01-01-1940 and 31-12-1969

SELECT first_name, last_name
FROM actors
WHERE last_name LIKE 'M%' AND
      date_of_birth BETWEEN '1940-01-01' AND '1969-12-31';

-- select the first and last names of the directors with nationality British,
-- French or German born between 01-01-1950 and 31-12-1980

SELECT first_name, last_name
FROM directors
WHERE (date_of_birth BETWEEN '1950-01-01' AND '1980-12-31') AND
      nationality IN ('British', 'French', 'German');

-- Challenge 3
-- select the American directors ordered from oldest to youngest

SELECT *
FROM directors
WHERE nationality = 'American'
ORDER BY date_of_birth;

-- return the distinct nationalities from the directors table

SELECT DISTINCT nationality
FROM directors;

-- return the first names, last names, and date of births of the 10
-- youngest female actors

SELECT first_name, last_name, date_of_birth
FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
LIMIT 10;

-- Challenge 4
-- return the top 3 movies with the highest international takings

SELECT *
FROM movie_revenues
WHERE international_takings IS NOT NULL
ORDER BY international_takings DESC
LIMIT 3;

-- concatenate the first and last names of the directors, separated by a
-- space, and call this new column "full_name"

SELECT (first_name || ' ' || last_name) AS full_name
FROM directors;
-- or
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM directors;
-- or
SELECT CONCAT_WS(' ', first_name, last_name) AS full_name
FROM directors;

-- return the actors with missing first_names or missing date_of_birth

SELECT *
FROM actors
WHERE (first_name IS NULL) OR
	    (date_of_birth IS NULL)
