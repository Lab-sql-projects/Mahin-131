USE hospital_db;

-- Clear data in correct order (child tables first)
DELETE FROM medical_records;
DELETE FROM appointments;
DELETE FROM doctors;
DELETE FROM patients;

-- Insert patients
INSERT INTO patients (name, dob, gender, phone) VALUES
('Alice Chen', '1990-05-15', 'Female', '555-1234'),
('Bob Smith', '1985-11-22', 'Male', '555-5678'),
('Eva Lee', '1978-03-30', 'Female', '555-9012');

-- Insert doctors
INSERT INTO doctors (name, specialization, email) VALUES
('Dr. David Kim', 'Cardiology', 'david.kim@hospital.com'),
('Dr. Maria Garcia', 'Neurology', 'maria.garcia@hospital.com'),
('Dr. James Wilson', 'Oncology', 'james.wilson@hospital.com');

-- Insert appointments
INSERT INTO appointments (patient_id, doctor_id, status, notes) VALUES
(1, 1, 'Completed', 'Regular checkup - BP normal'),
(2, 2, 'Scheduled', 'Neurological evaluation'),
(3, 3, 'Scheduled', 'Cancer screening consultation');

-- Insert medical records
INSERT INTO medical_records (patient_id, diagnosis, treatment, prescription) VALUES
(1, 'Hypertension', 'Lifestyle changes', 'Lisinopril 10mg daily'),
(2, 'Migraine', 'Stress management', 'Ibuprofen PRN'),
(3, 'Annual physical', 'Preventive care', 'None');