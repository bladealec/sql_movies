

-- Q1: Which director has the highest average IMDb score for their movies, considering directors with at least 2 movies in the dataset?
SELECT director_name, AVG(imdb_score) AS avg_imdb_score
FROM movies
GROUP BY director_name
HAVING COUNT(*) >= 2
ORDER BY avg_imdb_score DESC
LIMIT 1;

-- Q2: What is the average number of Facebook likes for actors, actresses, and directors combined in each movie?
SELECT movie_title, AVG(actor_1_facebook_likes + actor_2_facebook_likes + actor_3_facebook_likes + director_facebook_likes) AS avg_total_likes
FROM movies
GROUP BY movie_title
ORDER BY avg_total_likes DESC
LIMIT 5;

-- Q3: How many movies have a duration longer than the average duration of all movies in the dataset?
SELECT COUNT(*) AS movies_count
FROM movies
WHERE duration > (SELECT AVG(duration) FROM movies);

-- Q4: Which country produced the highest number of movies in the dataset?
SELECT country, COUNT(*) AS movie_count
FROM movies
GROUP BY country
ORDER BY movie_count DESC
LIMIT 1;

-- Q5: What is the average gross revenue per year for movies released after 2010?
SELECT title_year, AVG(gross) AS avg_gross_revenue
FROM movies
WHERE title_year > 2010
GROUP BY title_year
ORDER BY title_year;

-- Q6: How many movies have a budget greater than the average budget of all movies in the dataset and also have an IMDb score above 7.0?
SELECT COUNT(*) AS movies_count
FROM movies
WHERE budget > (SELECT AVG(budget) FROM movies)
AND imdb_score > 7.0;

-- Q7: What are the top 3 most common plot keywords in the dataset?
SELECT plot_keywords, COUNT(*) AS keyword_count
FROM movies
GROUP BY plot_keywords
ORDER BY keyword_count DESC
LIMIT 3;

-- Q8: Which movie has the highest ratio of Facebook likes to its budget?
SELECT movie_title, (CAST(movie_facebook_likes AS FLOAT) / budget) AS likes_to_budget_ratio
FROM movies
ORDER BY likes_to_budget_ratio DESC
LIMIT 1;

-- Q9: What is the average number of faces on movie posters for each genre?
SELECT genres, AVG(facenumber_in_poster) AS avg_faces_on_poster
FROM movies
GROUP BY genres
ORDER BY avg_faces_on_poster DESC;

-- Q10: Which actor/actress appears most frequently in the dataset (considering all three actor roles)?
SELECT actor_name, COUNT(*) AS appearance_count
FROM (
    SELECT actor_1_name AS actor_name FROM movies
    UNION ALL
    SELECT actor_2_name AS actor_name FROM movies
    UNION ALL
    SELECT actor_3_name AS actor_name FROM movies
) AS all_actors
GROUP BY actor_name
ORDER BY appearance_count DESC
LIMIT 1;