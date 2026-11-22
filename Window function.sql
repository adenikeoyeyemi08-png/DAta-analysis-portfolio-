--Window Function
--(Q14) Within each medical condition,which patients rank in the top 3 by highest billing amount?

SELECT Medical_condition,Name,
       billing_amount
FROM healthcare_data h1
WHERE 3>
      ( SELECT COUNT(DISTINCT billing_amount)
     FROM healthcare_data h2
     WHERE h2.Medical_condition = h1.Medical_Condition
     AND h2.Billing_Amount> h1.Billing_Amount
     )
     ORDER BY Medical_Condition,Billing_Amount,Name DESC;

  


     --(Q15) FOR each hospital,What is the cumulative(running) total of billing amount ordered
     -- chronologically by admission date?
   SELECT h1. Hospital,
          h1. date_of_Admission,
          h1. billing_amount,
         ( SELECT sum( h2.billing_amount)
         FROM healthcare_data AS h2
         WHERE h2.hospital = h1.hospital
          AND  h2.date_of_Admission <= h1.date_of_Admission
          )AS Running_total
          FROM healthcare_data AS h1
          ORDER BY h1.hospital,h1.date_of_Admission DESC;


--(Q16) what is the 30-days rolling average  of daily patients admissions across all hospital

SELECT h1.hospital,h1.date_of_Admission,
       ( 
         SELECT COUNT( h2.date_of_Admission)*1.0/30.0
         FROM healthcare_data AS h2
         WHERE h2.Date_of_Admission BETWEEN DATEADD(day,-29,h1.date_of_Admission) AND h1.date_of_Admission
         ) AS rolling_30_days_avg
         FROM healthcare_data AS h1
         GROUP BY h1.Hospital, h1.Date_of_Admission
         ORDER BY h1.Date_of_Admission;


 
--(Q17) HOW do doctor compare to one another in terms of patient volume?
--assign each doctor to a performance quartile and calculate their percentile rank
SELECT Doctor,
COUNT(*) AS total_patients,
         NTILE(4) OVER(ORDER BY COUNT(*)DESC) AS perfomance_quartile,
         PERCENT_rank()OVER(ORDER BY COUNT(*)DESC) AS percentile_rank
  FROM   healthcare_data 
GROUP BY Doctor
ORDER BY total_patients DESC;


--(Q18) For each patient,what was the billing amount of the previous admission at the same hospital,and how
-- does the current patient's bill compare to it?
   
  

 SELECT c.Name,
        c.hospital,
        c. Date_of_admission,
        p. Date_of_admission AS prev_date,
        p.billing_amount AS prev_bill,
        c.billing_amount AS cur_bill,
        c.billing_amount- p.billing_amount AS diff_bill
         FROM healthcare_data c
         LEFT JOIN healthcare_data p
         ON c.Name = p.Name
         AND c.Hospital = p.Hospital
         AND P.Date_of_Admission< c.Date_of_Admission
         ORDER BY c.Name,c.Date_of_Admission;

        

    
      