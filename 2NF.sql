-- this code creates a new table with a unique abilities column
CREATE TABLE dependencies AS SELECT 
DISTINCT split_value FROM split_abilities;

-- this code creates a new table with an autoincrementing primary key 
CREATE TABLE new_dependencies 
(id INTEGER PRIMARY KEY AUTOINCREMENT, 
new_abilities TEXT);

-- this code adds our new_abilities column into our new_dependencies table
insert into new_dependencies(new_abilities)
SELECT * FROM new_dependencies;

--linking table 
--new_dependencies and new_table 
CREATE TABLE abilities_pokemon AS SELECT id, pokedex_number FROM new_dependencies JOIN new_table
ON new_table.split_value = new_dependencies.new_abilities;


