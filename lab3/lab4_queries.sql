-- Lab 3: Advanced SQL Features for Hospital Database
-- Student ID: 2022521460131
-- Lab Tasks: View, Constraints, Index, Transaction, Complex Query, Bonus Role

-- Task 1: View
CREATE OR REPLACE VIEW view_patient_info AS
SELECT name, dob, gender
FROM patients;

-- Test View
SELECT * FROM view_patient_info;

-- Task 2: Integrity Constraints
ALTER TABLE medical_records
MODIFY treatment TEXT NOT NULL,
ADD CHECK (CHAR_LENGTH(treatment) >= 5);

ALTER TABLE doctors
MODIFY specialization VARCHAR(100) NOT NULL;

-- Task 3: Index
CREATE INDEX idx_doctor_id ON appointments(doctor_id);

-- Task 4: Transaction
START TRANSACTION;

INSERT INTO patients (name, dob, gender, phone) 
VALUES ('Transaction Test', '2000-01-01', 'Other', '999-9999');

UPDATE patients 
SET name = 'Updated Test' 
WHERE phone = '999-9999';

SELECT * FROM patients WHERE phone = '999-9999';

ROLLBACK;

SELECT * FROM patients WHERE phone = '999-9999';

-- Task 5: Complex Query
SELECT 
    p.name AS patient,
    d.name AS doctor,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed'
GROUP BY p.patient_id, d.name
HAVING COUNT(a.appointment_id) > (
    SELECT AVG(appt_count)
    FROM (
        SELECT COUNT(*) AS appt_count
        FROM appointments
        WHERE status = 'Completed'
        GROUP BY patient_id
    ) avg_table
);

-- Bonus: Authorization
CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'report123';
GRANT SELECT ON hospital_db.view_patient_info TO 'report_user'@'localhost';
FLUSH PRIVILEGES;
