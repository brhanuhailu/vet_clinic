/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu'; or SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT neutered FROM animals;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg>=10.4 OR weight_kg<=17.3 AND weight_kg BETWEEN 10.4 AND 17.3;


update animals SET species = 'unspecified';
update animals SET species = 'null';  or use  ROLLBACK;
update animals SET species = 'digimon' WHERE name LIKE '%mon'
update animals SET species = 'pokemon' WHERE name not LIKE '%mon'
BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN
DELETE from animals WHERE date_of_birth > '2022-01-01';
savepoint savept;
update animals set weight_kg = weight_kg * -1;
ROLLBACK to savept;
commit;

select count(id) from animals;
select count (*) from animals where escape_attempts = 0;
select Round(avg(weight_kg),2) from animals;
select neutered, sum(escape_attempts) as Escape_Attempts from animals group by neutered;
select species, min(weight_kg) as Min_Weight, max(weight_kg) as Max_weight from animals group by species;
select species, avg(escape_attempts) as Avg_Escape_Attempts from animals
where date_of_birth between '1990-01-01' and '2000-12-31'
group by species;



select * from animals
JOIN owners on animals.owner_id = owners.id
where owners.full_name = 'Melody Pond';

select * from animals
Join species on species.id = animals.species_id
where species.name = 'Pokemon';

select owners.full_name, animals.name 
from owners
left join animals on animals.owner_id = owners.id;

select count(animals.name), species.name 
from animals
join species on animals.species_id = species.id
group by species.name;

select species.name, owners.full_name, animals.name
from species
join animals on animals.species_id = species.id
join owners on animals.owner_id = owners.id
where species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell';

select animals.name as Animals_name, owners.full_name
from animals
join owners on animals.owner_id = owners.id
where owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;

select count(animals.name) as Total_Animals, owners.full_name
from animals
join owners on animals.owner_id = owners.id
group by owners.full_name
order by Total_Animals desc;

-- queies for project 3
-- who was the last animal seen by william Tatcher?
select animals.name, vets.name
from animals
join visits on animals.id = visits.animal_id
join vets on vets.id = visits.vet_id
where vets.name = 'William Tatcher'
order by visits.visited_date desc
limit 1;

-- How many different animals did Stephanie Mendez see?
select vets.name, count(animals.name) as Total_Animals
from animals
join visits on animals.id = visits.animal_id
join vets on vets.id = visits.vet_id
where vets.name = 'Stephanie Mendez'
group by vets.name;

-- List all vets and their specialties, including vets with no specialties.
select vets.name, species.name
from vets
left join specializations on vets.id = specializations.vet_id
left join species on species.id = specializations.species_id
order by vets.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select animals.name, visits.visited_date
from animals
join visits on animals.id = visits.animal_id
join vets on vets.id = visits.vet_id
where vets.name = 'Stephanie Mendez' and visits.visited_date between '2020-04-01' and '2020-08-30';

--What animal has the most visits to vets?
select animals.name, count(visits.animal_id) as Total_Visits
from animals
join visits on animals.id = visits.animal_id
group by animals.name
order by Total_Visits desc
limit 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  WHERE vets.name = 'Maisy SMith'
  ORDER BY visits.visited_date ASC lIMIT 1;

--  details for most recent vist : animal information, vet information, and visit date.
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  ORDER BY visits.visited_date DESC lIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM vets 
  JOIN visits ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN specializations ON vets.id = specializations.vet_id
  WHERE NOT specializations.species_id = animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name, species.name, count(species.name) from vets 
  JOIN visits on visits.vet_id = vets.id 
  JOIN animals on visits.animal_id = animals.id 
  JOIN species on animals.species_id = species.id 
  WHERE vets.name = 'Maisy SMith' 
  GROUP BY species.name, vets.name 
  ORDER BY count DESC lIMIT 1;