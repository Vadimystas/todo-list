CREATE SCHEMA todoapp;

CREATE TABLE todoapp.users (
	id SERIAL PRIMARY KEY,
	version BIGINT NOT NULL DEFAULT 1,
	first_name VARCHAR(100) NOT NULL CHECK (char_length(first_name) BETWEEN 3 AND 100),
	phone_number VARCHAR(15) NOT NULL CHECK (
		phone_number ~ '^\+?[1-9]\d{1,14}$' AND char_length(phone_number) BETWEEN 10 AND 15
	)
);

CREATE TABLE todoapp.tasks (
	id SERIAL PRIMARY KEY,
	version BIGINT NOT NULL DEFAULT 1,
	user_id INT NOT NULL REFERENCES todoapp.users(id) ON DELETE CASCADE,
	title VARCHAR(100) NOT NULL CHECK (char_length(title) BETWEEN 10 AND 100),
	description VARCHAR(1000) NOT NULL CHECK (char_length(description) BETWEEN 10 AND 1000),
	completed BOOLEAN NOT NULL DEFAULT FALSE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	completed_at TIMESTAMP
);