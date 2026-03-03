CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO users (name, email)
VALUES ('Alice', 'alice@email.com');
