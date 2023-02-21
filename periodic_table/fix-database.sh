#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -c"

# Rename columns in properties table
$PSQL "
  ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
  ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
  ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
"

# Add constraints and set columns to NOT NULL
$PSQL "
  ALTER TABLE elements ADD CONSTRAINT symbol_unique UNIQUE (symbol);
  ALTER TABLE elements ADD CONSTRAINT name_unique UNIQUE (name);
  ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
  ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
  ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
  ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
  ALTER TABLE properties ADD CONSTRAINT fk_properties_elements FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);
"

# Create types table and add foreign key to properties table
$PSQL "
  CREATE TABLE types (
    type_id SERIAL PRIMARY KEY,
    type VARCHAR NOT NULL
  );
  INSERT INTO types (type) VALUES ('nonmetal'), ('metal'), ('metalloid');
  ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id);
  UPDATE properties SET type_id = types.type_id FROM types WHERE properties.type = types.type;
  ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
"

# Update symbol column in elements table
$PSQL "
  UPDATE elements SET symbol = INITCAP(symbol);
"

# Alter atomic_mass column in properties table to DECIMAL
$PSQL "
  ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
"

# Remove trailing zeros in atomic_mass column in properties table
$PSQL "
  UPDATE properties SET atomic_mass = CAST(regexp_replace(CAST(atomic_mass AS text), '\.?0*$', '') AS DECIMAL);
"

# Insert new data
$PSQL "
  INSERT INTO elements (atomic_number, name, symbol) VALUES (9, 'Fluorine', 'F');
  INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (9, 18.998, -220, -188.1, 1);
  INSERT INTO elements (atomic_number, name, symbol) VALUES (10, 'Neon', 'Ne');
  INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (10, 20.18, -248.6, -246.1, 1);
"

# Remove row with atomic number 1000 from both tables
$PSQL "
  DELETE FROM elements WHERE atomic_number = 1000;
  DELETE FROM properties WHERE atomic_number = 1000;
"