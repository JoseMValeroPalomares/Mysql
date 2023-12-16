DROP DATABASE IF EXISTS insurances;

CREATE DATABASE insurances;
USE insurances;

CREATE TABLE clients (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_document_number VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE insurances (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    client_id INT UNSIGNED NOT NULL,
    percentage_covered TINYINT UNSIGNED NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    annual_cost DECIMAL(8, 2) NOT NULL,
    type ENUM("VEHICLE", "PROPERTY"),

    FOREIGN KEY (client_id) REFERENCES clients(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, -- Fixed the typo here: ON UPDATE RESTRICT to ON DELETE RESTRICT

    CONSTRAINT ck_percentage_covered_less_than_100 CHECK (percentage_covered <= 100) -- Corrected the typo: percetege_covered to percentage_covered
);

CREATE TABLE vehicles (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Added a primary key for the vehicles table
    insurances_id INT UNSIGNED NOT NULL,
    price DECIMAL (8, 2) NOT NULL,
    plate_number VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY (insurances_id) REFERENCES insurances(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE properties (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Added a primary key for the properties table
    insurances_id INT UNSIGNED NOT NULL,
    area DECIMAL (6, 2) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL,
    unit VARCHAR(255) NULL,

    FOREIGN KEY (insurances_id) REFERENCES insurances(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
