camper: /project$ psql --username=freecodecamp --dbname=postgres

Border style is 2.
Pager usage is off.
psql (12.17 (Ubuntu 12.17-1.pgdg22.04+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

postgres=> CREATE DATABASE universe;
CREATE DATABASE

postgres=> 

postgres=> \c universe
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
You are now connected to database "universe" as user "freecodecamp".

universe=> CREATE TABLE galaxy (
universe(>     galaxy_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR(100) UNIQUE NOT NULL,
universe(>     galaxy_type TEXT NOT NULL,
universe(>     distance_from_earth NUMERIC NOT NULL,
universe(>     has_life BOOLEAN,
universe(>     is_spherical BOOLEAN
universe(> );
CREATE TABLE

universe=> \d
                     List of relations
+--------+----------------------+----------+--------------+
| Schema |         Name         |   Type   |    Owner     |
+--------+----------------------+----------+--------------+
| public | galaxy               | table    | freecodecamp |
| public | galaxy_galaxy_id_seq | sequence | freecodecamp |
+--------+----------------------+----------+--------------+
(2 rows)

universe=> INSERT INTO galaxy (name, galaxy_type, distance_from_earth, has_life, is_spherical)
universe-> VALUES 
universe->     ('Milky Way', 'Spiral', 0, TRUE, TRUE),
universe->     ('Andromeda', 'Spiral', 2537000, FALSE, TRUE),
universe->     ('Triangulum', 'Spiral', 3000000, FALSE, TRUE),
universe->     ('Whirlpool', 'Spiral', 23000000, FALSE, TRUE),
universe->     ('Messier 87', 'Elliptical', 54000000, FALSE, FALSE),
universe->     ('Sombrero', 'Elliptical', 29000000, FALSE, FALSE);
INSERT 0 6

universe=> \d galaxy
                                               Table "public.galaxy"
+---------------------+------------------------+-----------+----------+-------------------------------------------+
|       Column        |          Type          | Collation | Nullable |                  Default                  |
+---------------------+------------------------+-----------+----------+-------------------------------------------+
| galaxy_id           | integer                |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| name                | character varying(100) |           | not null |                                           |
| galaxy_type         | text                   |           | not null |                                           |
| distance_from_earth | numeric                |           | not null |                                           |
| has_life            | boolean                |           |          |                                           |
| is_spherical        | boolean                |           |          |                                           |
+---------------------+------------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
    "galaxy_name_key" UNIQUE CONSTRAINT, btree (name)

universe=> CREATE TABLE star (
universe(>     star_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR(100) UNIQUE NOT NULL,
universe(>     galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
universe(>     age_in_millions_of_years INT NOT NULL,
universe(>     is_main_sequence BOOLEAN
universe(> );
CREATE TABLE

universe=> CREATE TABLE planet (
universe(>     planet_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR(100) UNIQUE NOT NULL,
universe(>     star_id INT REFERENCES star(star_id) NOT NULL,
universe(>     has_life BOOLEAN,
universe(>     distance_from_star NUMERIC NOT NULL,
universe(>     planet_type TEXT NOT NULL
universe(> );
CREATE TABLE

universe=> CREATE TABLE moon (
universe(>     moon_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR(100) UNIQUE NOT NULL,
universe(>     planet_id INT REFERENCES planet(planet_id) NOT NULL,
universe(>     diameter_km INT NOT NULL,
universe(>     is_spherical BOOLEAN
universe(> );
CREATE TABLE

universe=> INSERT INTO star (name, galaxy_id, age_in_millions_of_years, is_main_sequence)
universe-> VALUES 
universe->     ('Sun', 1, 4600, TRUE),
universe->     ('Sirius', 1, 250, TRUE),
universe->     ('Betelgeuse', 1, 8000, FALSE),
universe->     ('Proxima Centauri', 1, 4500, TRUE),
universe->     ('Rigel', 1, 8000, FALSE),
universe->     ('Alpha Centauri A', 1, 6000, TRUE);
INSERT 0 6

universe=> INSERT INTO planet (name, star_id, has_life, distance_from_star, planet_type)
universe-> VALUES 
universe->     ('Mercury', 1, FALSE, 0.39, 'Terrestrial'),
universe->     ('Venus', 1, FALSE, 0.72, 'Terrestrial'),
universe->     ('Earth', 1, TRUE, 1.00, 'Terrestrial'),
universe->     ('Mars', 1, FALSE, 1.52, 'Terrestrial'),
universe->     ('Jupiter', 1, FALSE, 5.20, 'Gas Giant'),
universe->     ('Saturn', 1, FALSE, 9.58, 'Gas Giant'),
universe->     ('Uranus', 1, FALSE, 19.18, 'Ice Giant'),
universe->     ('Neptune', 1, FALSE, 30.07, 'Ice Giant'),
universe->     ('Proxima b', 4, FALSE, 0.05, 'Exoplanet'),
universe->     ('Kepler-22b', 3, FALSE, 0.85, 'Exoplanet'),
universe->     ('TRAPPIST-1d', 3, FALSE, 0.03, 'Exoplanet'),
universe->     ('Gliese 581g', 2, FALSE, 0.15, 'Exoplanet');
INSERT 0 12

universe=> INSERT INTO moon (name, planet_id, diameter_km, is_spherical)
universe-> VALUES 
universe->     ('Luna', 3, 3475, TRUE),
universe->     ('Phobos', 4, 22, FALSE),
universe->     ('Deimos', 4, 12, FALSE),
universe->     ('Io', 5, 3643, TRUE),
universe->     ('Europa', 5, 3122, TRUE),
universe->     ('Ganymede', 5, 5268, TRUE),
universe->     ('Callisto', 5, 4821, TRUE),
universe->     ('Titan', 6, 5150, TRUE),
universe->     ('Enceladus', 6, 500, TRUE),
universe->     ('Mimas', 6, 396, TRUE),
universe->     ('Triton', 8, 2706, TRUE),
universe->     ('Charon', 9, 1212, TRUE),
universe->     ('Kepler-22b I', 10, 2100, TRUE),
universe->     ('Kepler-22b II', 10, 1900, TRUE),
universe->     ('TRAPPIST-1d I', 11, 1600, TRUE),
universe->     ('TRAPPIST-1d II', 11, 1200, TRUE),
universe->     ('Gliese 581g I', 12, 1000, TRUE),
universe->     ('Gliese 581g II', 12, 800, TRUE),
universe->     ('Gliese 581g III', 12, 600, TRUE),
universe->     ('Gliese 581g IV', 12, 500, TRUE);
INSERT 0 20

universe=> CREATE TABLE galaxy_types (
universe(>     galaxy_type_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR(50) UNIQUE NOT NULL,
universe(>     description TEXT
universe(> );
CREATE TABLE

universe=> INSERT INTO galaxy_types (name, description) 
universe-> VALUES 
universe->     ('Spiral', 'A galaxy with spiral arms, such as the Milky Way.'),
universe->     ('Elliptical', 'A round or oval-shaped galaxy with little gas and dust.'),
universe->     ('Irregular', 'A galaxy with no defined shape, often chaotic.');
INSERT 0 3








universe=> SELECT * FROM galaxy;

+-----------+------------+-------------+---------------------+----------+--------------+
| galaxy_id |    name    | galaxy_type | distance_from_earth | has_life | is_spherical |
+-----------+------------+-------------+---------------------+----------+--------------+
|         1 | Milky Way  | Spiral      |                   0 | t        | t            |
|         2 | Andromeda  | Spiral      |             2537000 | f        | t            |
|         3 | Triangulum | Spiral      |             3000000 | f        | t            |
|         4 | Whirlpool  | Spiral      |            23000000 | f        | t            |
|         5 | Messier 87 | Elliptical  |            54000000 | f        | f            |
|         6 | Sombrero   | Elliptical  |            29000000 | f        | f            |
+-----------+------------+-------------+---------------------+----------+--------------+
(6 rows)

universe=> SELECT * FROM star;

+---------+------------------+-----------+--------------------------+------------------+
| star_id |       name       | galaxy_id | age_in_millions_of_years | is_main_sequence |
+---------+------------------+-----------+--------------------------+------------------+
|       1 | Sun              |         1 |                     4600 | t                |
|       2 | Sirius           |         1 |                      250 | t                |
|       3 | Betelgeuse       |         1 |                     8000 | f                |
|       4 | Proxima Centauri |         1 |                     4500 | t                |
|       5 | Rigel            |         1 |                     8000 | f                |
|       6 | Alpha Centauri A |         1 |                     6000 | t                |
+---------+------------------+-----------+--------------------------+------------------+
(6 rows)


universe=> SELECT * FROM planet;

+-----------+-------------+---------+----------+--------------------+-------------+
| planet_id |    name     | star_id | has_life | distance_from_star | planet_type |
+-----------+-------------+---------+----------+--------------------+-------------+
|         1 | Mercury     |       1 | f        |               0.39 | Terrestrial |
|         2 | Venus       |       1 | f        |               0.72 | Terrestrial |
|         3 | Earth       |       1 | t        |               1.00 | Terrestrial |
|         4 | Mars        |       1 | f        |               1.52 | Terrestrial |
|         5 | Jupiter     |       1 | f        |               5.20 | Gas Giant   |
|         6 | Saturn      |       1 | f        |               9.58 | Gas Giant   |
|         7 | Uranus      |       1 | f        |              19.18 | Ice Giant   |
|         8 | Neptune     |       1 | f        |              30.07 | Ice Giant   |
|         9 | Proxima b   |       4 | f        |               0.05 | Exoplanet   |
|        10 | Kepler-22b  |       3 | f        |               0.85 | Exoplanet   |
|        11 | TRAPPIST-1d |       3 | f        |               0.03 | Exoplanet   |
|        12 | Gliese 581g |       2 | f        |               0.15 | Exoplanet   |
+-----------+-------------+---------+----------+--------------------+-------------+
(12 rows)

universe=> SELECT * FROM moon;
+---------+-----------------+-----------+-------------+--------------+
| moon_id |      name       | planet_id | diameter_km | is_spherical |
+---------+-----------------+-----------+-------------+--------------+
|       1 | Luna            |         3 |        3475 | t            |
|       2 | Phobos          |         4 |          22 | f            |
|       3 | Deimos          |         4 |          12 | f            |
|       4 | Io              |         5 |        3643 | t            |
|       5 | Europa          |         5 |        3122 | t            |
|       6 | Ganymede        |         5 |        5268 | t            |
|       7 | Callisto        |         5 |        4821 | t            |
|       8 | Titan           |         6 |        5150 | t            |
|       9 | Enceladus       |         6 |         500 | t            |
|      10 | Mimas           |         6 |         396 | t            |
|      11 | Triton          |         8 |        2706 | t            |
|      12 | Charon          |         9 |        1212 | t            |
|      13 | Kepler-22b I    |        10 |        2100 | t            |
|      14 | Kepler-22b II   |        10 |        1900 | t            |
|      15 | TRAPPIST-1d I   |        11 |        1600 | t            |
|      16 | TRAPPIST-1d II  |        11 |        1200 | t            |
|      17 | Gliese 581g I   |        12 |        1000 | t            |
|      18 | Gliese 581g II  |        12 |         800 | t            |
|      19 | Gliese 581g III |        12 |         600 | t            |
|      20 | Gliese 581g IV  |        12 |         500 | t            |
+---------+-----------------+-----------+-------------+--------------+
(20 rows)

universe=> SELECT * FROM galaxy_types;
+----------------+------------+---------------------------------------------------------+
| galaxy_type_id |    name    |                       description                       |
+----------------+------------+---------------------------------------------------------+
|              1 | Spiral     | A galaxy with spiral arms, such as the Milky Way.       |
|              2 | Elliptical | A round or oval-shaped galaxy with little gas and dust. |
|              3 | Irregular  | A galaxy with no defined shape, often chaotic.          |
+----------------+------------+---------------------------------------------------------+
(3 rows)

universe=> alter table galaxy_types rename column galaxy_type_id to galaxy_types_id;
ALTER TABLE
