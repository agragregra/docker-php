CREATE DATABASE IF NOT EXISTS example;
USE example;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL
);

INSERT INTO users (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Doe', 'jane@example.com');
