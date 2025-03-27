USE hospital_db;

-- Insert patients
INSERT INTO patients (name, dob, gender, phone) VALUES
('Alice Chen', '1990-05-15', 'Female', '555-1234'),
('Bob Smith', '1985-11-22', 'Male', '555-5678'),
('Eva Lee', '1978-03-30', 'Female', '555-9012');

-- Insert doctors
INSERT INTO doctors (name, specialization, email) VALUES
('Dr. David Kim', 'Cardiology', 'david.kim@hospital.com'),
('Dr. Maria Garcia', 'Neurology', 'maria.garcia@hospital.com');

-- Insert appointments
INSERT INTO appointments (patient_id, doctor_id, date, status) VALUES
(1, 1, '2023-06-10 09:00:00', 'Completed'),
(2, 2, '2023-06-15 14:30:00', 'Scheduled');

-- Insert medical records
INSERT INTO medical_records (patient_id, diagnosis) VALUES
(1, 'Hypertension - prescribed Lisinopril'),
(2, 'Migraine - advised rest and hydration');  

INSERT INTO doctors VALUES 
(3, 'Dr. James Wilson', 'Oncology', 'james.wilson@hospital.com');

INSERT INTO appointments VALUES
(3, 1, '2023-06-20 10:00:00', 'Scheduled');

INSERT INTO medical_records VALUES
(3, 3, 'Annual physical - healthy');
