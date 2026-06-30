CREATE TABLE AdminUsers (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE Whitelist (
    whitelist_id SERIAL PRIMARY KEY,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE Tariffs (
    tariff_id SERIAL PRIMARY KEY,
    tariff_name VARCHAR(100) NOT NULL,
    hourly_rate DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ParkingEvents (
    event_id SERIAL PRIMARY KEY,
    license_plate VARCHAR(20) NOT NULL,
    entry_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    exit_time TIMESTAMP,
    calculated_fee DECIMAL(10, 2) DEFAULT 0.00,
    is_paid BOOLEAN DEFAULT FALSE NOT NULL
);
