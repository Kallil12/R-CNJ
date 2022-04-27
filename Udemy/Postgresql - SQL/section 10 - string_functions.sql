-- Challenge 1
-- select the directors first and last names and movie names in upper case

SELECT UPPER(d.first_name), UPPER(d.last_name), UPPER(m.movie_name)
FROM directors d
JOIN movies m ON m.director_id = d.director_id;

-- select the first and last names, in initial capitalisation format, of all the
-- actors who have starred in a Chinese or Korean movie

SELECT INITCAP(a.first_name), INITCAP(a.last_name)
FROM actors a
JOIN movies_actors ma ON a.actor_id = ma.actor_id
JOIN movies m ON ma.movie_id = m.movie_id
WHERE (m.movie_lang = 'Chinese') OR (m.movie_lang = 'Korean');

-- retrieve the reversed first and last names of each directors and the first
-- three characters of their nationality

SELECT REVERSE(d.first_name), REVERSE(d.last_name), LEFT(d.nationality,3)
FROM directors d;

-- retrieve the initials of each director and display it in one column named
-- 'initials'

SELECT CONCAT(d.first_name, ' ', d.last_name, ' - ',LEFT(d.first_name,1),'.', LEFT(d.last_name,1)) AS "initials"
FROM directors d;

-- Challenge 2
-- use the substring function to retrieve the first 6 characters of each movie
-- name and the year they released

SELECT SUBSTRING(movie_name, 0, 6), SUBSTRING(release_date::TEXT, 0, 5)
FROM movies;

-- retrieve the first name initial and last name of every actor born in May

SELECT CONCAT(SUBSTRING(first_name,1,1), '.' , ' ', last_name) AS name
FROM actors
WHERE SPLIT_PART(date_of_birth::TEXT, '-', 2) = '05'

-- replace the movie language for all English language movies, with age
-- certificate rating 18 to 'Eng'

SELECT REPLACE(movie_lang, 'English', 'Eng')
FROM movies
WHERE age_certificate = '18';
