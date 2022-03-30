-- CREATING TABLES
CREATE TABLE movies (

	movie_id SERIAL PRIMARY KEY,
	movie_name VARCHAR(50) NOT NULL,
	movie_length INT,
	movie_lang VARCHAR(20),
	release_date DATE,
	age_certificate VARCHAR(5),
	director_id INT REFERENCES directors (director_id)
);

SELECT * FROM movies;

-- creating the movie_revenues table
CREATE TABLE movie_revenues(

	revenue_id SERIAL PRIMARY KEY,
	movie_id INT REFERENCES movies (movie_id),
	domestic_takings NUMERIC(6,2),
	international_takings NUMERIC(6,2)
);

SELECT * FROM movie_revenues;
-- creating the movies_actors table, it is a junction table

CREATE TABLE movies_actors(

	movie_id INT REFERENCES movies (movie_id),
	actor_id INT REFERENCES actors (actor_id),
	PRIMARY KEY (movie_id, actor_id)
);

-- ADD COLUMNS AND ALTER EXISTING ONES
ALTER TABLE examples
ADD COLUMN email VARCHAR(50) UNIQUE;

ALTER TABLE examples
ADD COLUMN nationality VARCHAR(30),
ADD COLUMN age INT NOT NULL;


-- modify a column data type

ALTER TABLE examples
ALTER COLUMN nationality TYPE CHAR(3);

ALTER TABLE examples
ALTER COLUMN last_name TYPE VARCHAR(50),
ALTER COLUMN email TYPE VARCHAR(80);


-- Challenge



INSERT INTO owners (first_name, last_name, city, state, email)
VALUES ('Samuel', 'Smith', 'Boston', 'MA', 'samsmith@gmail.com'),
   ('Emma', 'Johnson', 'Seattle', 'WA', 'emjohnson@gmail.com'),
   ('John', 'Oliver', 'New York', 'NY', 'johnoliver@gmail.com'),
   ('Olivia', 'Brown', 'San Francisco', 'CA', 'oliviabrown@gmail.com'),
   ('Simon', 'Smith', 'Dallas', 'TX', 'sismith@gmail.com'),
   ('', 'Maxwell', '', 'CA', 'lordmaxwell@gmail.com');

INSERT INTO owners (first_name, last_name, city, state, email)
VALUES (NULL , 'Silva', NULL, 'MA', 'silva_silva@gmail.com');

INSERT INTO pets (species, full_name, age, owner_id)
VALUES ('Dog', 'Rex', 6, 1),
   ('Rabbit', 'Fluffy', 2, 5),
   ('Cat', 'Tom', 8, 2),
   ('Mouse', 'Jerry', 2, 2),
   ('Dog', 'Biggles', 4, 1),
   ('Tortoise', 'Squirtle', 42, 3);

UPDATE pets
SET age = 3
WHERE id = 2;

DELETE FROM owners
WHERE id IN (6,7);

SELECT * FROM owners;
SELECT * FROM pets;

SELECT DISTINCT(first_name) FROM owners;
