-- ========================================
-- DATA PREPARATION
-- ========================================

-- Create cleaned dataset with relevant indicators
SELECT 
    region_id,
    region_name,
    population,
    income,
    education_level,
    health_access,
    transport_score,
    housing_quality
INTO Cleaned_Equity_Data
FROM Raw_Equity_Data
WHERE population IS NOT NULL
  AND income IS NOT NULL;

-- Normalize indicators for clustering
SELECT 
    region_id,
    (income - AVG(income) OVER()) / STDEV(income) OVER() AS norm_income,
    (education_level - AVG(education_level) OVER()) / STDEV(education_level) OVER() AS norm_education,
    (health_access - AVG(health_access) OVER()) / STDEV(health_access) OVER() AS norm_health,
    (transport_score - AVG(transport_score) OVER()) / STDEV(transport_score) OVER() AS norm_transport,
    (housing_quality - AVG(housing_quality) OVER()) / STDEV(housing_quality) OVER() AS norm_housing
INTO Normalized_Equity_Data
FROM Cleaned_Equity_Data;

-- ========================================
-- CLUSTERING LOGIC
-- ========================================

-- Assign clusters using K-means (pseudo-SQL logic)
-- Note: Actual clustering would be done in Python/R or via ML extension
SELECT 
    region_id,
    CASE 
        WHEN norm_income > 0 AND norm_education > 0 THEN 'Cluster A'
        WHEN norm_health < 0 AND norm_transport < 0 THEN 'Cluster B'
        ELSE 'Cluster C'
    END AS equity_cluster
INTO Clustered_Equity_Data
FROM Normalized_Equity_Data;

-- ========================================
-- PCA COMPONENTS (SIMULATED)
-- ========================================

-- Simulate PCA scores for visualization
SELECT 
    region_id,
    0.35 * norm_income + 0.25 * norm_education + 0.15 * norm_health AS pca_component_1,
    0.20 * norm_transport + 0.30 * norm_housing AS pca_component_2
INTO PCA_Scores
FROM Normalized_Equity_Data;

-- ========================================
-- FINAL JOIN FOR DASHBOARD
-- ========================================

-- Combine clustering and PCA for Power BI
SELECT 
    c.region_id,
    c.equity_cluster,
    p.pca_component_1,
    p.pca_component_2,
    d.region_name,
    d.population
INTO Final_Equity_Model
FROM Clustered_Equity_Data c
JOIN PCA_Scores p ON c.region_id = p.region_id
JOIN Cleaned_Equity_Data d ON c.region_id = d.region_id;
