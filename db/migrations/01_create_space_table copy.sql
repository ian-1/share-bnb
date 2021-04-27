CREATE TABLE space(id SERIAL PRIMARY KEY, name VARCHAR(300), description VARCHAR(500), price_per_night MONEY, availibility BOOLEAN DEFAULT TRUE);
