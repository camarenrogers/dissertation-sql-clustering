-- Create temp table to store distances 
CREATE TABLE region_distances ( 
    region_id INT, 
    cluster_id INT, 
    distance FLOAT 
); 
 
-- Calculate distances 
INSERT INTO region_distances 
SELECT r.region_id, 
       c.cluster_id, 
       SQRT( 
           POWER(r.z_unemployment_rate - c.centroid_unemployment, 2) + 
           POWER(r.z_income_poverty_rate - c.centroid_income_poverty, 2) + 
           POWER(r.z_housing_deprivation_score - c.centroid_housing, 2) + 
           POWER(r.z_education_access_index - c.centroid_education, 2) + 
           POWER(r.z_health_access_score - c.centroid_health_access, 2) 
       ) AS distance 
FROM regional_metrics r 
JOIN centroids c ON 1=1; 
