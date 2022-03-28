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
