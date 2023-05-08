/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
id int,
name varchar(50),
date_of_birth date,
escape_attempts int,
neutered boolean,
weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species varchar(255);

CREATE TABLE owners (id SERIAL PRIMARY KEY, 
full_name varchar(255), age integer);

CREATE TABLE species (
id SERIAL PRIMARY KEY,
name varchar(255)
);

Begin
Alter table animals drop column species
commit

Alter table animals add column species_id int;
Alter table animals add constraint FK_species Foreign key (species_id) references species(id);

Alter table animals add column owner_id int;
Alter table animals add constraint FK_owners Foreign key (owner_id) references owners(id);

-- Create a table for the vets
CREATE TABLE vets (
id SERIAL PRIMARY KEY,
name varchar(255),
age integer,
date_of_graduation date
);

-- create many-to-many table for species and vets
CREATE TABLE specializations(vet_id INTEGER REFERENCES vets(id),
species_id INTEGER REFERENCES species(id),
CONSTRAINT vet_species_pk PRIMARY KEY(vet_id,species_id) );

-- create table for animals and vet
CREATE TABLE visits (
    animal_id INT CONSTRAINT fk_animal_id REFERENCES animals(id),
    vet_id INT CONSTRAINT fk_visits_vet_id REFERENCES vets(id),
    visited_date date NOT NULL DEFAULT CURRENT_DATE
);

-- alter table owners add column email varchar(120);
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- add index
CREATE INDEX animals_id_asc ON visits(animal_id ASC);
CREATE INDEX vets_id_asc ON visits(vet_id ASC);
CREATE INDEX email_asc ON owners(email ASC);