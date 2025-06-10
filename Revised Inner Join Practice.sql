

Select Distinct
--Used Distinct to get rid of duplicate game titles
	title,
	YEAR(date_release) AS year_release,
	rating,
	user_reviews,
	(price_final - price_original)AS final_price_difference,
	discount,
	all_games.Genre AS games_genre
From steam_game_recom AS steam
Inner JOIN game_sales AS all_games
ON steam.title = all_games.Name
--Wrote Inner Join to combine only games with exact title on all_games table to steam_game_recom
WHERE 
	rating IN ('Positive', 'Very Positive', 'Overwhelmingly Positive', 'Mostly Positive') AND
	all_games.Genre IN ('Action', 'Adventure', 'Role-Playing', 'Fighting')
--Only wanted games people most liked and was in the category was wanted
ORDER BY discount DESC, user_reviews DESC
--Categorized games by biggest discount and most user reviews

--Github AI help
SELECT
    ROW_NUMBER() OVER (ORDER BY year_release DESC, user_reviews DESC) AS row_num,
    *
FROM (
    SELECT DISTINCT
        title,
        YEAR(date_release) AS year_release,
        rating,
        user_reviews,
        (price_final - price_original) AS final_price_difference,
        discount,
        all_games.Genre AS games_genre
    FROM steam_game_recom AS steam
    INNER JOIN game_sales AS all_games
        ON steam.title = all_games.Name
    WHERE
        rating IN ('Positive', 'Very Positive', 'Overwhelmingly Positive', 'Mostly Positive')
        AND all_games.Genre IN ('Action', 'Adventure', 'Role-Playing', 'Fighting')
) AS deduped
ORDER BY year_release DESC, user_reviews DESC;