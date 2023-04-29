-- creates a new table where the abilities are split
-- so that there aren't multiple values in each row 
CREATE TABLE split_abilities AS
SELECT abilities, 
       trim(value) AS split_value
FROM testing, 
     json_each('["' || replace(abilities, ',', '","') || '"]')
WHERE split_value <> '';

SELECT * FROM testing JOIN split_abilities;

-- gets rid of repetition 
DELETE FROM split_abilities
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM split_abilities
    GROUP BY abilities, split_value
);

SELECT * FROM split_abilities;

-- get rid of single quotes, and square brackets 
UPDATE split_abilities SET split_value = TRIM 
(split_value,  ']');
UPDATE split_abilities SET split_value = TRIM 
(split_value,  '[');
UPDATE split_abilities SET split_value = TRIM 
(split_value,  " ' ");

-- joins our new split abilities table without the 
-- brackets and single quotes to our originial testing table
CREATE TABLE new_cleaned AS
SELECT testing.*, split_abilities.split_value
FROM testing JOIN split_abilities ON testing.abilities = split_abilities.abilities;

-- final table that gets rid of our abilities column that had 
-- mulitple values in a row
CREATE TABLE new_table AS 
SELECT against_bug, against_dark, against_dragon, against_electric,
against_fairy, against_fight, against_fire, against_flying, against_ghost, 
against_grass, against_ground, against_ice, against_normal, against_poison, 
against_psychic, against_rock, against_steel, against_water, attack, base_egg_steps, 
base_happiness, base_total, capture_rate, classfication, defense, experience_growth, 
height_m, hp, name, percentage_male, pokedex_number, sp_attack, sp_defense,
speed, type1, type2, weight_kg, generation, is_legendary, split_value
FROM new_cleaned;





