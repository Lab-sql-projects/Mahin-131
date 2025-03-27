USE hospital_db;

-- 1. Active appointments with patient and doctor details
SELECT 
    p.name AS patient, 
    d.name AS doctor, 
    a.date AS appointment_time,
    a.status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Scheduled';

-- 2. Patient demographics
SELECT 
    gender, 
    COUNT(*) AS total_patients,
    FLOOR(AVG(YEAR(CURDATE()) - YEAR(dob))) AS avg_age
FROM patients
GROUP BY gender;

-- 3. Doctors by specialty
SELECT 
    specialization, 
    GROUP_CONCAT(name) AS doctors,
    COUNT(*) AS count
FROM doctors
GROUP BY specialization;

-- 4. Medical treatments
SELECT 
    p.name AS patient,
    mr.diagnosis,
    mr.prescription
FROM medical_records mr
JOIN patients p ON mr.patient_id = p.patient_id
WHERE mr.prescription IS NOT NULL;

-- 5. Oldest patient record
SELECT 
    name, 
    dob,
    TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM patients
ORDER BY dob ASC
LIMIT 1;