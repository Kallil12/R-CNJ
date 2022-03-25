
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
