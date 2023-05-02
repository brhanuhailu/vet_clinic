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
