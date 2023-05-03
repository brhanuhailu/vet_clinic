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

