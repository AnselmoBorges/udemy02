-- Criando o schema:
create schema covid;

-- Criando a tabela Municipios:
CREATE TABLE covid.municipios
(
    codigo_ibge text,
    nome text,
    latitude text,
    longitude text,
    capital text,
    codigo_uf text
)

TABLESPACE pg_default;

ALTER TABLE covid.municipios
    OWNER to postgres;

-- Criando a tabela dados covid:
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
)

TABLESPACE pg_default;

ALTER TABLE covid.covid_casos
    OWNER to postgres;

-- Realizar a criacao da tabela consolidada pela data:
create table covid.consolidada_3103 as
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
on covid_casos.city_ibge_code = municipios.codigo_ibge
where covid_casos.date = '2020-03-31';