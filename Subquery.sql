--Subquery
--(Q6) Which patients were billed above the overall average billing amount,and 
--what medical condition were they admitted for?
   SELECT medical_condition,admission_type,billing_amount
   FROM healthcare_data
   WHERE billing_amount >( SELECT AVG(billing_amount)
                          FROM healthcare_data
                         
);
 --(Q7),Which hopital  treat more patients than the average number of patients per hospital
    --across the entire netwok
SELECT hospital,
COUNT(*) AS total_patients
FROM healthcare_data
GROUP BY Hospital
HAVING COUNT(*) >(SELECT AVG(hospital_count) 
                 FROM
                 (SELECT COUNT(*) AS hospital_count
                 FROM healthcare_data
                 GROUP BY hospital
                 ) AS hospital_count
                 );
--(Q8) For each medical condition,what is the most frequently prescribed medication?
   SELECT Medical_condition,medication,
   COUNT(*) AS frequently_prescribed
   FROM healthcare_data
   GROUP BY Medical_condition,medication
   HAVING COUNT(*) =(SELECT MAX(med_count)
                    FROM  (      
                    SELECT COUNT(*) AS med_count
                    FROM healthcare_data AS ht
                    WHERE  ht.Medical_Condition = healthcare_data.Medical_condition
                    GROUP BY ht.Medication
                    ) AS ht
                    )
                   ORDER BY frequently_prescribed DESC;
                   
 --(Q9 ) Are there any Doctor who have treated patients across more than three different medical conditions?
 SELECT Doctor,
 COUNT(DISTINCT medical_condition) AS med_Distinct_count
 FROM healthcare_data
 GROUP BY Doctor
 HAVING COUNT(DISTINCT Medical_Condition)>3
 ORDER BY med_Distinct_count DESC;