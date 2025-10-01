UPDATE regional_metrics 
SET cluster_id = ( 
    SELECT TOP 1 cluster_id 
    FROM region_distances d 
    WHERE d.region_id = regional_metrics.region_id 
    ORDER BY distance ASC 
); 
