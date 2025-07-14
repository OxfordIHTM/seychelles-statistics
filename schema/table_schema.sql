CREATE TABLE `population_midyear_by_district` (
  `year` int,
  `island` varchar(200),
  `island_code` varchar(200),
  `region` varchar(200),
  `region_code` varchar(200),
  `district` varchar(200),
  `district_code` varchar(200),
  `population` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_bin;

UPDATE population_midyear_by_district SET population = NULL WHERE population = 0;
