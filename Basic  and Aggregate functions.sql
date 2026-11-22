
--Basic Functions And Aggregations
 --(Q 1),How many patients were admitted for each medical condition,and
 --what percentage of total admissions does each condition represent?

 SELECT Medical_condition,
 COUNT(*) AS Total_patients,
 COUNT(*)* 100.0/(SELECT COUNT(*) FROM healthcare_data) AS perc_of_admission
 FROM healthcare_data
 GROUP BY Medical_condition
 ORDER BY Total_patients DESC;

 --(Q 2),What is the average,minimum,and Maximum billing amount for each combination 
 --of gender and admission type?

 SELECT gender,admission_type,
 AVG(billing_amount) AS avg_bill,
 MIN(billing_amount) AS lowest_bill,
 MAX(billing_amount) AS highest_bill
 FROM healthcare_data
 GROUP BY gender,Admission_type
 ORDER BY avg_bill DESC,
         lowest_bill DESC,
         highest_bill DESC;

  --Q3 For  each medical condition,how many patients received,Normal,Abdnormal,and Inclusive test ressults respectively
   SELECT Medical_condition,Test_Results,
   COUNT(*) AS Total_patients
   FROM healthcare_data
   GROUP BY Medical_condition,Test_Results
   ORDER BY Total_patients DESC;

  

   --(Q4) Which insurance provider covers the highest number of patients and 
   --How does patient distribution vary across all five provider

    SELECT Insurance_provider,
    COUNT(*) AS Highest_numb_of_patients
    FROM Healthcare_data
    GROUP BY Insurance_provider
    ORDER BY Highest_numb_of_patients DESC;

--(Q5),What is the average age of patients admitted under each admission type( Electvive,Emergency,Urgent)?
      SELECT admission_type,
      AVG (age) AS avg_age
      FROM healthcare_data
      GROUP BY admission_type 
      ORDER BY avg_age DESC;

  
   




  
 

           
