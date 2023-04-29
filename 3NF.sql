SELECT * FROM new_table;

-- this code creates a tempprary table with distinct combination 
-- values 

-- type 1 and type from testing 
-- get distinct values 
-- create a table with type 1 and type 2 distinct 
CREATE TABLE temp_distinct AS SELECT 
type1, type2 FROM testing; 


SELECT * FROM temp_distinct;

-- this code creates a auto incrementing PK , Type 1, Type 2 linked to against 
CREATE TABLE types
(id INTEGER PRIMARY KEY AUTOINCREMENT, 
type_1 TEXT, 
type_2 TEXT) 

INSERT INTO types (type_1, type_2) SELECT DISTINCT type1, type2 FROM temp_distinct;

SELECT * FROM types;

-- creating against table 

--type foreign key many-to-one
--join types to new table 

CREATE TABLE main3NF AS SELECT * FROM types JOIN new_table 
ON new_table.type1 = types.type_1 AND
new_table.type2 = types.type_2;

SELECT * FROM main3NF;

-- two new tables 
-- against table 

CREATE TABLE temp_against AS SELECT id, against_bug,
 against_dark, against_dragon, against_electric,
against_fairy, against_fight, against_fire, against_flying, against_ghost, 
against_grass, against_ground, against_ice, against_normal, against_poison, 
against_psychic, against_rock, against_steel, against_water FROM main3NF;

SELECT * FROM temp_against;

CREATE TABLE final_against AS SELECT DISTINCT 
id, against_bug, against_dark, against_dragon, against_electric,
against_fairy, against_fight, against_fire, against_flying, against_ghost, 
against_grass, against_ground, against_ice, against_normal, against_poison, 
against_psychic, against_rock, against_steel, against_water FROM temp_against ;

SELECT * FROM final_against;

CREATE TABLE mainFinal AS SELECT DISTINCT  pokedex_number, attack, base_egg_steps, 
base_happiness, base_total, capture_rate, classfication, defense, experience_growth, 
height_m, hp, name, percentage_male, sp_attack, sp_defense,
speed, weight_kg, generation, is_legendary, split_value, id FROM main3NF GROUP BY pokedex_number;

DROP TABLE testing;
DROP TABLE dependencies;
DROP TABLE new_abilities;
