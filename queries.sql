USE hospital_db;

-- 1. Show all scheduled appointments (filter with WHERE)
SELECT p.name AS patient, d.name AS doctor, a.date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Scheduled';

-- 2. Count patients by gender (GROUP BY)
SELECT gender, COUNT(*) AS total
FROM patients
GROUP BY gender;

-- 3. Find doctors in Cardiology (WHERE + ORDER BY)
SELECT name, email
FROM doctors
WHERE specialization = 'Cardiology'
ORDER BY name;

-- 4. Get oldest patient (LIMIT)
SELECT name, dob
FROM patients
ORDER BY dob ASC
LIMIT 1;


SELECT p.name, mr.diagnosis
FROM medical_records mr
JOIN patients p ON mr.patient_id = p.patient_id
WHERE mr.diagnosis LIKE '%prescribed%'
AND p.gender = 'Female';