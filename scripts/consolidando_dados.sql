## Criaçao tabelas Postgres

-- covid_casos:
CREATE TABLE covid.covid_casos
(
    date text,
    state text,
    city text,
    place_type text,
    confirmed text,
    deaths text,
    is_last text,
    estimated_population_2019 text,
    city_ibge_code text,
    confirmed_per_100k_inhabitants text,
    death_rate text
);

ALTER TABLE covid.covid_casos
    OWNER to postgres;

-- estados:
CREATE TABLE covid.estados
(
    codigo_uf text COLLATE pg_catalog."default",
    uf text COLLATE pg_catalog."default",
    nome text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE covid.estados
    OWNER to postgres;

-- municipios:
CREATE TABLE covid.municipios
(
    codigo_ibge text COLLATE pg_catalog."default",
    nome text COLLATE pg_catalog."default",
    latitude text COLLATE pg_catalog."default",
    longitude text COLLATE pg_catalog."default",
    capital text COLLATE pg_catalog."default",
    codigo_uf text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE covid.municipios
    OWNER to postgres;

#### Procedimento:
-- Table: covid.municipios

-- DROP TABLE covid.municipios;

CREATE TABLE covid.municipios
(
    codigo_ibge text COLLATE pg_catalog."default",
    nome text COLLATE pg_catalog."default",
    latitude text COLLATE pg_catalog."default",
    longitude text COLLATE pg_catalog."default",
    capital text COLLATE pg_catalog."default",
    codigo_uf text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE covid.municipios
    OWNER to postgres;
		
-- Numero de municipios:	
select count(codigo_ibge) from covid.municipios
where codigo_ibge in 
(select city_ibge_code from covid.covid_casos)

-- Join dos dados das 2:
select 
	covid_casos.date, 
	covid_casos.state,
	covid_casos.city,
	covid_casos.place_type,
	covid_casos.confirmed,
	covid_casos.deaths,
	covid_casos.is_last,
	covid_casos.estimated_population_2019,
	covid_casos.city_ibge_code,
	covid_casos.confirmed_per_100k_inhabitants,
	covid_casos.death_rate,
	municipios.latitude,
	municipios.longitude
from covid.covid_casos
inner join covid.municipios
on covid_casos.city_ibge_code = municipios.codigo_ibge;

-- Validando Geolocalização:
select * from covid.municipios where codigo_ibge = '1200013';

-- Cria tabela consolidada:
create table covid.consolidada as
select 
	covid_casos.date, 
	covid_casos.state,
	covid_casos.city,
	covid_casos.place_type,
	covid_casos.confirmed,
	covid_casos.deaths,
	covid_casos.is_last,
	covid_casos.estimated_population_2019,
	covid_casos.city_ibge_code,
	covid_casos.confirmed_per_100k_inhabitants,
	covid_casos.death_rate,
	municipios.latitude,
	municipios.longitude
from covid.covid_casos
inner join covid.municipios
on covid_casos.city_ibge_code = municipios.codigo_ibge;

-- Validando tabela Consolidada:
select * from covid.consolidada;
