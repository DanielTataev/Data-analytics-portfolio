# 🎬 Movie Revenue and Actor Analysis

## Project Overview

This project analyzes movie data to answer three key questions:

1. **Gross of a Movie vs. Directors**: Which directors are associated with the highest-grossing movies?
2. **Actor Genre Preference**: Which genre do actors prefer based on the number of movies they appear in?
3. **Actor Combinations and Gross**: Which combinations of actors are linked to the highest-grossing movies?

The analysis uses Python libraries such as Pandas, Seaborn, and Matplotlib to clean, process, and visualize the data.

---

## Dataset Description

The dataset contains the following columns:

- **Poster_Link**: URL to the movie's poster.
- **Series_Title**: Name of the movie.
- **Released_Year**: Year the movie was released.
- **Certificate**: Certification of the movie (e.g., PG, R).
- **Runtime**: Total runtime of the movie.
- **Genre**: Genre(s) of the movie.
- **IMDB_Rating**: IMDb rating of the movie.
- **Overview**: Short summary or plot description.
- **Meta_score**: Meta score of the movie.
- **Director**: Name of the director.
- **Star1, Star2, Star3, Star4**: Names of the stars in the movie.
- **No_of_votes**: Total number of votes on IMDb.
- **Gross**: Total gross revenue of the movie.

---

## Technologies Used

- **Python**: Core language for the analysis.
- **Pandas**: For data manipulation and cleaning.
- **Seaborn** and **Matplotlib**: For data visualization.
- **Jupyter Notebook**: To document and run the analysis.

---

## Key Insights

### 1. **Gross of a Movie vs. Directors**

This analysis determines which directors are associated with the highest-grossing movies. By grouping the dataset by directors and summing their associated gross revenue, we can identify top-performing directors.

**Example Code**:
```python
# Group by Director and calculate total gross
director_gross = movies.groupby('Director')['Gross'].sum().reset_index()
director_gross.sort_values(by='Gross', ascending=False).head(10)
```
### 2. **Actor Genre Preference**

This analysis determines which directors are associated with the highest-grossing movies. By grouping the dataset by directors and summing their associated gross revenue, we can identify top-performing directors.

**Example Code**:
```python
# Split and explode Genre column to associate multiple genres
movies['Genre'] = movies['Genre'].str.split(', ')
movies_genres = movies.explode('Genre')

# Count occurrences for each actor and genre
actor_genre_count = movies_genres.groupby(['Actor', 'Genre']).size().reset_index(name='Movie_Count')
preferred_genre = actor_genre_count.loc[actor_genre_count.groupby('Actor')['Movie_Count'].idxmax()]
```
### 3. **Actor Combinations and Gross**

The combination of actors that result in high-grossing movies is identified by concatenating actor names and calculating the total gross for each combination.

**Example Code**:
```python
# Concatenate actor names and group by combination
movies['Actor_Combination'] = movies['Star1'] + ', ' + movies['Star2'] + ', ' + movies['Star3'] + ', ' + movies['Star4']
actor_combination_gross = movies.groupby('Actor_Combination')['Gross'].sum().reset_index()
actor_combination_gross.sort_values(by='Gross', ascending=False).head(10)
```
---

## Conclusion
This project provides insights into the movie industry by analyzing directors, actor preferences, and actor combinations associated with high-grossing movies. It demonstrates proficiency in data analysis, data visualization, and Python programming.
