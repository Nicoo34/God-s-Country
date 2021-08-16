CREATE TABLE `status` (
	`charid` int(11) NOT NULL AUTO_INCREMENT,
  	`user_id` int(11) NOT NULL,
	`status` VARCHAR(255) NOT NULL DEFAULT '0',
	PRIMARY KEY (`charid`)
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=100
;
