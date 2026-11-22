--Common Table Expressions(CTEs)
--(Q10) What is the average lenght of hopital stay(in days) for each admission type,
-- and which type results in the longest stays on average?


WITH admission_stay_lenght AS(
     SELECT admission_type,
     DATEDIFF(Day,date_of_admission,discharge_date) AS lenght_of_stay_days
   FROM healthcare_data
),
average_stays AS (
    SELECT admission_type,
       AVG(lenght_of_stay_days) AS avg_lenght_of_stay_days   
           FROM admission_stay_lenght
           GROUP BY admission_type
)
    SELECT 
         admission_type,
       avg_lenght_of_stay_days
       FROM average_stays
       ORDER BY avg_lenght_of_stay_days  DESC;

--(Q11) hOW can insurance providers be classified into revenue tiers(High,medium,low) 
-- based on the total billing amount they are responsible for?
 WITH revenue_tires  AS (
      SELECT Insurance_provider,
      SUM(billing_amount) AS total_billing
      FROM healthcare_data
      GROUP BY Insurance_Provider
      )
      SELECT Insurance_provider,
             Total_billing,
             CASE
               WHEN Total_billing>= 51500000 THEN'HIGH'
               WHEN Total_billing>= 50000000 THEN'Medium'
               ELSE 'LOW'
               END AS revenue_tires
               FROM  revenue_tires
               ORDER BY total_billing DESC;
  
  --( Q12) which five hospital generate highest total billing revenue,and what was the average billing
  --per patient at each of those hospital
   WITH hospital_Revenue AS(
       SELECT Hospital,
       SUM(billing_amount) AS total_billing,
       AVG(billing_amount) AS avg_billing
       FROM Healthcare_data
       GROUP BY Hospital
      )
     SELECT TOP 5
     hospital,
     total_billing,
     avg_billing
     FROM hospital_Revenue
     ORDER BY total_billing DESC;
     
     --(Q13) What is the monthly admission count  for each year in the dataset.and how does each
     --month compare to the previous month within the same year?
      WITH   Month_Admissions AS(
          SELECT MONTH(Date_of_Admission) AS Month_admission,
                 YEAR (Date_of_Admission) AS Year_admission,
                 COUNT(*) AS total_Admissions
           FROM healthcare_data
           GROUP BY MONTH( Date_of_admission), 
                    YEAR (Date_of_admission)
                    )
             SELECT CurrentMonth.Month_admission,
                    CurrentMonth.Year_admission,
                    CurrentMonth.total_admissions,
                    previousMonth.total_admissions AS Previous_Month_admissions,
                    currentMonth.total_admissions-previousMonth.total_admissions AS admission_difference

              FROM  Month_Admissions AS CurrentMonth
              LEFT JOIN Month_Admissions AS previousMonth
              ON currentMonth.Month_admission =previousMonth.Month_admission
              AND CurrentMonth.Year_admission=previousMonth.Year_admission 
             ORDER BY CurrentMonth.Month_admission,CurrentMonth.Year_admission DESC;


       
  