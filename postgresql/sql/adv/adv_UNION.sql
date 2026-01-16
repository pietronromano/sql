/*

    Combining Queries (UNION, INTERSECT, EXCEPT) 
    The results of two queries can be combined using the set operations union, intersection, and difference. 
    The syntax is
        query1 UNION [ALL] query2
        query1 INTERSECT [ALL] query2
        query1 EXCEPT [ALL] query2

    Summary
        Use the UNION to combine result sets of two queries and return distinct rows.
        Use the UNION ALL to combine the result sets of two queries but retain the duplicate rows.

    SEE:
        - https://www.postgresql.org/docs/current/queries-union.html
        - https://neon.com/postgresql/postgresql-tutorial/postgresql-union

*/

-- Setting up sample tables
DROP TABLE IF EXISTS top_rated_films;
DROP TABLE IF EXISTS most_popular_films;

--The following statements create two tables top_rated_films and most_popular_films, and insert data into these tables:

CREATE TABLE top_rated_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);
CREATE TABLE most_popular_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);
INSERT INTO top_rated_films(title, release_year)
VALUES
   ('The Shawshank Redemption', 1994),
   ('The Godfather', 1972),
   ('The Dark Knight', 2008),
   ('12 Angry Men', 1957);
INSERT INTO most_popular_films(title, release_year)
VALUES
  ('An American Pickle', 2020),
  ('The Godfather', 1972),
  ('The Dark Knight', 2008),
  ('Greyhound', 2020);

-- The following statement retrieves data from the top_rated_films table:
SELECT * FROM top_rated_films;

--The following statement retrieves data from the most_popular_films table:
SELECT * FROM most_popular_films;

-- Basic PostgreSQL UNION example: distinct rows
-- The following statement uses the UNION operator to combine data from the queries that retrieve data from the top_rated_films and most_popular_films
SELECT * FROM top_rated_films
UNION
SELECT * FROM most_popular_films;

-- PostgreSQL UNION ALL example: duplicate rows
--The following statement uses the UNION ALL operator to combine result sets from queries that retrieve data from top_rated_films and most_popular_films tables:
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films;

-- PostgreSQL UNION ALL with ORDER BY clause example
--To sort the result returned by the UNION operator, you place the ORDER BY clause after the second query:
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films
ORDER BY title;