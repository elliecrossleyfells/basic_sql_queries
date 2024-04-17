/* VIEW THE TABLES */
SELECT * FROM solar_system;

SELECT * FROM planet_moons;

SELECT * FROM space_missions
ORDER BY launch_year DESC;


/* MANIPULATING TABLE DATA USING DML COMMANDS */

#Retrieve table ordered by planet_size rather than planet_id
SELECT * FROM solar_system
ORDER BY planet_size DESC; #order from small-large rather than large-small which is the default 

#Change the data in the planet_type column from lowercase to uppercase.
UPDATE solar_system
SET planet_size = UPPER(planet_size);

#Delete the first entry in all tables, because this entry is a star and not a planet and so shouldn't be in the table.
#Must delete from all 3 tables.
#(To run this, safe update mode must be turned OFF)
DELETE FROM solar_system
WHERE planet_id = 0;

DELETE FROM planet_moons
WHERE planet_id = 0;

DELETE FROM space_missions
WHERE planet_id = 0;



/* RETRIEVING DATA AND USING AGGREGATE FUNCTIONS TO FIND OUT INFORMATION ABOUT THE DATA */

#Finding the average number of moons a planet has and total number of moons in the solar system.
SELECT AVG(number_of_moons) FROM solar_system;
SELECT SUM(number_of_moons) FROM solar_system;
#Avg number of moons = 33 (to nearest whole number).
#Total of moons in the solar system = 293.

#Using an aggregate function to find out the average number of moons grouped by planet size.
SELECT planet_size, AVG(number_of_moons) AS avg_moons
FROM solar_system
GROUP BY planet_size;
#The above shows large planets have the highest average number of moons.

#Finding out the date of the oldest space mission.
SELECT mission_name, launch_year
FROM space_missions
WHERE launch_year = (
	SELECT MIN(launch_year)
    FROM space_missions
    );
#The above shows Sputnik 1 is the oldest space mission.

#Finding how many planets have no moons
#Use of the wildcard '%' incase we were unsure how the data has been entered (e.g it could have been entered as "NoMoons" "None" "No Moon" for example)
SELECT planet_id, main_moon_name
FROM planet_moons
WHERE main_moon_name LIKE "No%";
#The above shows 2 planets have no moons



/* JOINING THE TABLES */

#Tables are related by the primary key: planet_id.
#Join the tables, providing better visualisation of the planets and their associated space missions & moons.

SELECT *
FROM planet_moons AS moons #alisas use for brevity.
LEFT JOIN space_missions AS miss
	USING (planet_id); #specify this column as it is the primary key for all the tables, and stops the column being duplicated in the join.
    
SELECT *
FROM solar_system AS ss 
RIGHT JOIN planet_moons AS moons
	USING (planet_id);

#We can also join all three tables using RIGHT JOIN.
SELECT *
FROM solar_system AS ss 
RIGHT JOIN planet_moons AS moons
	USING (planet_id)
RIGHT JOIN space_missions AS miss
	USING (planet_id);
    
#Join tables and display only select columns, below displays the planet name, it's main moon, and the moon's orbital period (this will be used below)
SELECT ss.planet_name, moons.main_moon_name, moons.moon_orbital_period_days
FROM solar_system AS ss
JOIN planet_moons AS moons ON ss.planet_id = moons.planet_id;
	
/* Now the tables are joined, the column orbital_period_days is ambiguous as it could mean the orbital period of the planet, or moon.
Rename the column this for clarification for other users that may not be familiar with the data in the table. */
ALTER TABLE planet_moons
RENAME COLUMN orbital_period_days TO moon_orbital_period_days;
    
/* STORED FUNCTION */
#Creating a stored function that takes the moon_orbital_period_days and converts it hours

DELIMITER //
CREATE FUNCTION days_to_hours(moon_orbital_period_days FLOAT)
RETURNS FLOAT
DETERMINISTIC #This keyword indicates that the function always produces the same result for the same input parameters
BEGIN
    DECLARE orbital_hours FLOAT;
    SET orbital_hours = moon_orbital_period_days * 24;
    RETURN orbital_hours;
END
// DELIMITER ;

#Now the function can be stored, and the converted values appear in a new column to the right
SELECT planet_id, main_moon_name, moon_orbital_period_days, days_to_hours(moon_orbital_period_days) AS moon_orbital_period_hours
FROM planet_moons;

    
    

