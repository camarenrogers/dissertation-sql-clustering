SELECT cluster_id, 
       AVG(z_unemployment_rate) AS centroid_unemployment, 
       AVG(z_income_poverty_rate) AS centroid_income_poverty, 
       AVG(z_housing_deprivation_score) AS centroid_housing, 
       AVG(z_education_access_index) AS centroid_education, 
       AVG(z_health_access_score) AS centroid_health_access 
FROM regional_metrics 
GROUP BY cluster_id; 
  