CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE citizens (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  full_name VARCHAR(255),
  phone VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE emergency_reports (
  id SERIAL PRIMARY KEY,
  citizen_id INT REFERENCES citizens(id),
  emergency_type VARCHAR(100) NOT NULL,
  description TEXT,
  latitude DECIMAL(10,8),
  longitude DECIMAL(11,8),
  address TEXT,
  severity VARCHAR(50),
  priority VARCHAR(50),
  status VARCHAR(50) DEFAULT 'reported',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE responders (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  responder_type VARCHAR(100),
  current_location TEXT,
  availability BOOLEAN DEFAULT TRUE
);

CREATE TABLE hospitals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  location TEXT,
  beds_available INT DEFAULT 0,
  icu_available INT DEFAULT 0
);

CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  channel VARCHAR(50),
  message TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
