CREATE DATABASE picorhood DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON picorhood.* TO 'web'@'localhost' IDENTIFIED BY 'project';

use picorhood;


CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	userid VARCHAR(15) NOT NULL UNIQUE,
	name VARCHAR(20),
	pwd VARCHAR(20) NOT NULL, 
	email VARCHAR(50) UNIQUE,
	gender CHAR(1) NOT NULL
);

INSERT INTO users VALUES (1, 'hyejung2', 'hyejung jang', '12345', 'hyejung-s@nate.com', 'F');
