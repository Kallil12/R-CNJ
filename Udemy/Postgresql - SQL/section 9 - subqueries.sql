-- Challenge 1
-- Select the first and last names of all the actors older than Marlon Brando

SELECT a.first_name, a.last_name
FROM actors a
WHERE a.date_of_birth < (SELECT date_of_birth
						 FROM actors
						 WHERE first_name = 'Marlon' AND last_name = 'Brando')
ORDER BY a.first_name;

-- Select the movie names of all movies that have domestic takings above 300
-- million

SELECT movie_name
FROM movies
JOIN movie_revenues ON movies.movie_id = movie_revenues.movie_id
WHERE movie_revenues.movie_id IN (SELECT movie_id
								  FROM movie_revenues
								  WHERE domestic_takings > 300 AND
								        domestic_takings IS NOT NULL);

-- Return the shortest and longest movie length for movies with an above average
-- domestic takings

SELECT MIN(movie_length), MAX(movie_length)
FROM movies mo
JOIN movie_revenues movre ON movre.movie_id = mo.movie_id
WHERE movre.domestic_takings > (SELECT AVG(domestic_takings)
                      			FROM movie_revenues
							    					WHERE domestic_takings IS NOT NULL);

-- Challenge 2
-- Select the first name, last name and date of birth for the oldest actors of
-- each gender

SELECT act1.first_name, act1.last_name, act1.date_of_birth
FROM actors act1
WHERE act1.date_of_birth = (SELECT MIN(act2.date_of_birth)
												    FROM actors act2
												    WHERE act1.gender = act2.gender);

-- Select the movie name, movie length and age certificate for movies with an
-- above average length for their age certificate

SELECT mo1.movie_name, mo1.movie_length, mo1.age_certificate
FROM movies mo1
WHERE mo1.movie_length > (SELECT AVG(mo2.movie_length)
						  						FROM movies mo2
						  						WHERE mo1.age_certificate = mo2.age_certificate)
ORDER BY mo1.age_certificate;
