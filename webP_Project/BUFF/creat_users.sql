CREATE DATABASE picorhood DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON picorhood.* TO 'web'@'localhost' IDENTIFIED BY 'tiger';

use picorhood;

CREATE TABLE picture (
	pictureID INT AUTO_INCREMENT PRIMARY KEY, 
	Date DATETIME,
	Title VARCHAR(100) not null,
	Text TEXT,
	file BLOB NOT NULL,
	FOREIGN KEY(userid) REFERENCES users(userid)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);


