# Self-Service Mortgage Insurance Dashboard

## Project Goal
Provide instrument for the lenders and KAMs to use independently for data insights and reporting

## Project Overview
This Power BI project provides a comprehensive self-service tool for Mortgage Insurance Lenders in Canada, offering key insights into business performance over historic periods. The dashboard organizes and analyzes lender data, including borrower information, product performance, and geographical trends. By answering crucial business questions, the dashboard helps lenders make strategic, data-driven decisions to improve portfolio growth and optimize risk management. This project includes processing and analyzing datasets related to mortgage insurance applications and lender performance.

The dashboard is built on the data creation step described here:

*Disclaimer: The report does not represent any Company, Institution or Country  and uses dummy dataset for demonstration purposes only.*
  
---

## Questions Answered

* What is the total insured amount by province for X lender last quarter and how it compares with overall market?
* Which province is bringing in more clients with higher risk?
* Which sales reps are following rules the least?
* What is our borrower profile on average?

---

## Samples from the dashboard

I used Power Query to clean and transform the data. Other tools used include; slicers, filters and measures. Leveraging visualization tools, I created charts, graphs, and pivot tables to showcase key Performance metrics.

**Volumes Overview**

![Test](PowerBI/Self%20Serive%20Insurance%20Dashboard/Volumes.JPG)


!([PowerBI/Self Serive Insurance Dashboard/Volumes.JPG](https://github.com/DanielTataev/Data-analytics-portfolio/blob/00a0defc9867163747005d3684fd400dda8bdbe6/PowerBI/Self%20Serive%20Insurance%20Dashboard/Volumes.JPG))


```
### 2. **Actor Genre Preference**

This analysis determines which directors are associated with the highest-grossing movies. By grouping the dataset by directors and summing their associated gross revenue, we can identify top-performing directors.

**Example Code**:
```python
# Split and explode Genre column to associate multiple genres
movies['Genre'] = movies['Genre'].str.split(', ')
movies_genres = movies.explode('Genre')
```

# Count occurrences for each actor and genre
actor_genre_count = movies_genres.groupby(['Actor', 'Genre']).size().reset_index(name='Movie_Count')
preferred_genre = actor_genre_count.loc[actor_genre_count.groupby('Actor')['Movie_Count'].idxmax()]

## Conclusion
This project provides insights into the movie industry by analyzing directors, actor preferences, and actor combinations associated with high-grossing movies. It demonstrates proficiency in data analysis, data visualization, and Python programming.
