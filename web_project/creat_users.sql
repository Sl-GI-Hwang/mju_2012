CREATE DATABASE picorhood DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON picorhood.* TO 'web' IDENTIFIED BY 'project';

use picorhood;


CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	userid VARCHAR(15) NOT NULL UNIQUE,
	name VARCHAR(20),
	pwd VARCHAR(20) NOT NULL, 
	email VARCHAR(50) UNIQUE,
	gender CHAR(1) NOT NULL,
	location VARCHAR(50),
	location_lat double,
	location_lon double
);

INSERT INTO users VALUES (1, 'Manager4', 'hyejung jang', '159357', 'hyejung-s@nate.com', 'F');

CREATE TABLE picture (
	pictureID INT AUTO_INCREMENT PRIMARY KEY, 
	Date DATETIME,
	Title VARCHAR(100) not null,
	Text TEXT,
	pictureName VARCHAR(100),
	userid VARCHAR(15) NOT NULL,
	location VARCHAR(50),
	location_lat double,
	location_lon double,
	FOREIGN KEY(userid) REFERENCES users(userid)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE comment (
	commentID INT AUTO_INCREMENT PRIMARY KEY, 
	Date DATETIME,
	Text TEXT not null,
	userid VARCHAR(15) NOT NULL,
	FOREIGN KEY(userid) REFERENCES users(userid)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	pictureID INT NOT NULL,
	FOREIGN KEY(pictureID) REFERENCES picture(pictureID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);


