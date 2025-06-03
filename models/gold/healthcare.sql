
select * from {{ ref('healthcare_stg') }}
where (
    patient_id is not null or
    admission_date is not null or
    discharge_date is not null or
    medical_condition is not null or
    prescription is not null or
    doctor is not null or
    hospital is not null or
    insurance_provider is not null or
    bill_amount is not null
)
