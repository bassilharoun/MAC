-- Create tables

-- therapist Data
CREATE TABLE therapist (
    therapist_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) not null,
    contact VARCHAR(255) not null,
    expertise INT not null,
    Availability TIMESTAMP not null,
    qualifications VARCHAR(255),  
    constraint therapist_uq unique(contact),
    constraint therapist_check check(expertise >= 1)
);

-- Client Data
CREATE TABLE client(
    client_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) not null,
    contact VARCHAR(255) not null,
    Age INT not null,
    gender VARCHAR(50),
    issues VARCHAR(255) not null, 
    constraint client_check check(age >= 18),
    constraint client_uq unique(contact)
);

-- Session Data
CREATE TABLE session(
    session_id VARCHAR(255) PRIMARY KEY,
    date DATE not null,
    time TIME not null,
    duration INT,
    notes TEXT,
    client_id VARCHAR(255) not null,
	constraint session_check check(duration >= 1),
    CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client(client_id)
);

-- Feedback Data
CREATE TABLE feedback (
    feedback_id VARCHAR(255) PRIMARY KEY,
    session_id VARCHAR(255) not null,
    client_id VARCHAR(255) not null,
    feedback TEXT,
    CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES session(session_id),
    CONSTRAINT fk_client_feedback FOREIGN KEY (client_id) REFERENCES client(client_id)
);

-- Reports and Statistics
CREATE TABLE reports_and_statistics (
    report_id VARCHAR(255) PRIMARY KEY,
    completed_sessions INT not null,
    avg_session_duration DECIMAL(10, 2),
    client_evaluations TEXT
);

-- Payment Management
CREATE TABLE payment_management (
    payment_id VARCHAR(255) PRIMARY KEY,
    client_id VARCHAR(255) not null,
    therapist_id VARCHAR(255) not null,
    amount DECIMAL(10, 2) not null,
    payment_status VARCHAR(50) not null,
    CONSTRAINT fk_client_payment FOREIGN KEY (client_id) REFERENCES client(client_id),
    CONSTRAINT fk_counselor_payment FOREIGN KEY (therapist_id) REFERENCES  therapist(therapist_id)
);

-- Custom Recommendations
CREATE TABLE custom_recommendations (
    recommendation_id VARCHAR(255) PRIMARY KEY,
    client_id VARCHAR(255) not null,
    Recommendations TEXT not null
);

-- Group Sessions
CREATE TABLE group_Sessions (
    group_session_id VARCHAR(255) PRIMARY KEY,
    date DATE not null,
    time TIME not null,
    therapist_id VARCHAR(255) not null,
    participants TEXT not null,
    CONSTRAINT fk_counselor_payment FOREIGN KEY (therapist_id) REFERENCES  therapist(therapist_id)
);

alter table therapist
add email varchar(50);

alter table therapist
alter column  email  char(5);

alter table therapist
drop column  email;