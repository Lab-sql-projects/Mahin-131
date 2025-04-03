-- LAB 2 SOLUTION (Hospital Database)
-- ==================================
-- Purpose: Demonstrate joins, updates, aggregations, and subqueries
-- Database: hospital_db (patients, doctors, appointments, medical_records)

-- 1. TABLE VERIFICATION (Verify 4 tables with 3+ records)
SELECT 'patients' AS table_name, COUNT(*) FROM patients
UNION ALL SELECT 'doctors', COUNT(*) FROM doctors
UNION ALL SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL SELECT 'medical_records', COUNT(*) FROM medical_records;

-- 2. JOIN QUERIES
-- A) INNER JOIN: Active patient appointments with doctor details
SELECT p.name AS patient, 
       d.name AS doctor, 
       a.date AS appointment_time,
       a.status
FROM appointments a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Scheduled'
ORDER BY a.date;

-- B) LEFT JOIN: All doctors with appointment statistics
SELECT d.name, 
       d.specialization,
       COUNT(a.appointment_id) AS total_appointments,
       SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_count,
       MIN(a.date) AS first_appointment,
       MAX(a.date) AS last_appointment
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id
ORDER BY total_appointments DESC;

-- 3. UPDATE: Promote senior specialists
SET @updated_count = 0;
UPDATE doctors
SET name = CONCAT('Sr. ', name),
    email = CONCAT('senior_', email)
WHERE specialization IN ('Cardiology', 'Neurology')
AND created_at < NOW() - INTERVAL 3 YEAR
LIMIT 2;  -- Safety limit
SET @updated_count = ROW_COUNT();

-- 4. DELETE: Clean up old test appointments
SET @deleted_count = 0;
DELETE FROM appointments
WHERE status = 'Cancelled'
AND date < NOW() - INTERVAL 6 MONTH
AND (notes LIKE '%test%' OR notes LIKE '%demo%');
SET @deleted_count = ROW_COUNT();

-- 5. AGGREGATION: Specialty performance metrics
SELECT 
    d.specialization,
    COUNT(DISTINCT d.doctor_id) AS doctor_count,
    COUNT(a.appointment_id) AS total_appointments,
    ROUND(COUNT(a.appointment_id)/COUNT(DISTINCT d.doctor_id),1) AS avg_appointments_per_doctor,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_count
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.specialization
HAVING COUNT(DISTINCT d.doctor_id) >= 1
ORDER BY total_appointments DESC;

-- 6. SUBQUERY: Identify high-engagement patients
SELECT p.name, 
       p.phone,
       (SELECT COUNT(*) 
        FROM appointments a 
        WHERE a.patient_id = p.patient_id) AS appointment_count,
       (SELECT MAX(date) 
        FROM appointments a 
        WHERE a.patient_id = p.patient_id) AS last_visit
FROM patients p
WHERE (
    SELECT COUNT(*) 
    FROM appointments a 
    WHERE a.patient_id = p.patient_id
) > (
    SELECT AVG(appt_count)
    FROM (
        SELECT COUNT(*) AS appt_count
        FROM appointments
        GROUP BY patient_id
    ) AS counts
)
ORDER BY appointment_count DESC;

-- VERIFICATION OUTPUT
SELECT CONCAT(@updated_count, ' doctors promoted to senior') AS update_result;
SELECT CONCAT(@deleted_count, ' old appointments deleted') AS delete_result;