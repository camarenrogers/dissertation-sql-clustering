UPDATE regional_metrics 
SET cluster_id = FLOOR(RAND() * K);  -- Replace K with desired number of clusters