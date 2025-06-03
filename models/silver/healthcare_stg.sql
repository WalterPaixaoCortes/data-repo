
WITH source AS (
    SELECT * FROM {{ source('bronze', 'healthcare_dataset') }}
),

cleaned AS (
    SELECT
        TRIM(COALESCE("Patient ID", '')) as patient_id,
        TRIM(COALESCE("Medical Condition", '')) as medical_condition,
        TRIM(COALESCE("Gender", '')) as gender,
        CAST(NULLIF("Age", NULL) AS INTEGER) as age,
        TRIM(COALESCE("Blood Type", '')) as blood_type,
        TRIM(COALESCE("Doctor", '')) as doctor,
        TRIM(COALESCE("Hospital", '')) as hospital,
        TRIM(COALESCE("Admission Type", '')) as admission_type,
        CAST(NULLIF(TRIM("Insurance Provider"), '') AS VARCHAR) as insurance_provider,
        CAST(NULLIF("Billing Amount", NULL) AS DECIMAL(10,2)) as bill_amount,
        CAST(NULLIF("Room Number", NULL) AS INTEGER) as room_number,
        TO_DATE(NULLIF(TRIM("Date of Admission"), ''), 'mm/dd/YYYY') as admission_date,
        TO_DATE(NULLIF(TRIM("Discharge Date"), ''), 'mm/dd/YYYY') as discharge_date,
        TRIM(COALESCE("Medication", '')) as prescription,
        TRIM(COALESCE("Test Results", '')) as test_results,
        CURRENT_TIMESTAMP as loaded_at
    FROM source
)

SELECT * FROM cleaned
