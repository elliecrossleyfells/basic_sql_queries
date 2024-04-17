
/*
A SQL project.

There are three tables that each contain different information about the planets and their associated moons and space missions.
The data is manipulated and built-in functions are used to gain insights about the planets, such as:
average moons per planet, total number of moons, average moon orbital period, oldest space mission
Finally, the tables are joined to better visualise the data, with some further manipulation and use of a stored function to convert values. 

A schema/database was created called "astronomy" by choosing the "create a new schema" button in the top left hand corner of MySQL

#USE astronomy;

/* CREATE THE TABLES */

#Create and define the tables.
#Also define a PRIMARY KEY: This ensures each data row can be uniquely identified using this key.

CREATE TABLE solar_system (
  planet_id INT NOT NULL,
  planet_name VARCHAR(50) UNIQUE,
  planet_type VARCHAR(50),
  planet_size VARCHAR(50),
  number_of_moons INT,
  distance_from_sun_au FLOAT,
  PRIMARY KEY (planet_id)
);

#Insert the data into the table, typing it in the order or the columns defined above.
INSERT INTO solar_system (planet_id, planet_name, planet_type, planet_size, number_of_moons, distance_from_sun_au)
VALUES
(0,'Sun', 'Main Sequence Star', 'large', 0,0.0),
(1,'Mercury', 'Rocky', 'small', 0, 0.4),
(2,'Venus', 'Rocky', 'medium', 0, 0.7),
(3,'Earth', 'Rocky', 'medium', 1, 1.0),
(4,'Mars', 'Rocky', 'small', 2, 1.5),
(5,'Jupiter', 'Gas Giant', 'large', 95 , 5.2),
(6,'Saturn', 'Gas Giant', 'large', 146 , 9.5),
(7,'Uranus', 'Ice Giant', 'large', 28 , 20.0),
(8,'Neptune', 'Ice Giant', 'large', 16 , 30.0),
(9,'Pluto', 'Dwarf', 'small', 5 , 39.0);

CREATE TABLE planet_moons (
  planet_id INT NOT NULL,
  main_moon_name VARCHAR(50) NOT NULL,
  orbital_period_days FLOAT NOT NULL,
  PRIMARY KEY (planet_id)
  );

INSERT INTO planet_moons (planet_id, main_moon_name, orbital_period_days)
VALUES
(0, 'No moons', 0.0),
(1, 'No moons', 0.0),
(2, 'No moons', 0.0),
(3, 'Moon', 27.0),
(4, 'Phobos', 0.2),
(5, 'Ganyemede', 7.0),
(6, 'Titan', 16.0),
(7, 'Titania', 8.7),
(8, 'Triton', 5.9),
(9, 'Charon', 6.7);

CREATE TABLE space_missions (
  planet_id INT NOT NULL,
  mission_name VARCHAR(50) NOT NULL,
  launch_year DATE,
  PRIMARY KEY (planet_id)
  );

INSERT INTO space_missions (planet_id, mission_name, launch_year)
VALUES
(0, 'Parker Solar Probe', '2018-08-12'),
(1, 'Messenger', '2004-08-03'),
(2, 'Venera 7', '1978-05-20'),
(3, 'Sputnik 1', '1957-10-04'),
(4, 'Mariner 4', '1971-11-14'),
(5, 'Pioneer 10', '1973-12-01'),
(6, 'Cassini', '1997-10-15'),
(7, 'Voyager 2', '1977-08-20'),
(8, 'No mission', NULL),
(9, 'New Horizons', '2006-01-19');