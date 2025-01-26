--CHAPTER 3
-- EXERCISE 1 - return all columns from Courses table
SELECT *
  FROM Courses
-- EXERCISE 2 - return 3 columns from Courses (CourseNumber, CourseDescription, CourseUnits) in order by CourseNumber from Courses
SELECT CourseNumber, CourseDescription, CourseUnits
  FROM Courses
  ORDER BY CourseNumber

-- EXERCISE 3 - return one column with LastName, FirstName in alphabetical order from Students
SELECT (LastName + ', ' + FirstName) AS FullName
  From Students
  ORDER BY LastName;

--EXERCISE 4 - return columns with LastName, FirstName and AnnualSalary of $60K or more in decending order by salary from Instructors
SELECT LastName, FirstName, AnnualSalary
  FROM Instructors
  Where AnnualSalary >= 60000
  Order by AnnualSalary DESC;

 --EXERCISE 5 - return LastName, FirstName, HireDate for those hired in 2022, in HireDate order from Instructors
 SELECT LastName, FirstName, HireDate
   FROM Instructors
   WHERE HireDate BETWEEN '2022-01-01' AND '2022-12-31'
   ORDER BY HireDate;

--EXERCISE 6  - return FirstName, LastName, EnrollmentDate, CurrentDate, MonthsAttended - sort by months attended from Students
SELECT FirstName, LastName, EnrollmentDate, GETDATE() as CurrentDate, DATEDIFF(month, EnrollmentDate, GETDATE()) as MonthsAttended 
  FROM Students
  ORDER BY MonthsAttended;

-- EXERCISE 7 - return FirstName, LastName, AnnualSalary - only the top 20% based on salary
SELECT TOP 20 PERCENT FirstName, LastName, AnnualSalary
  FROM Instructors
  ORDER BY AnnualSalary;

--EXERCISE 8 - return LastName, FirstName from Students - only G last names in alphabetical order
SELECT LastName, FirstName
  From Students
  WHERE LastName LIKE '[G]%'
  ORDER BY LastName;

 --EXERCISE 9 - return LastName, FirstName, EnrollmentDate, GraduationDate -- enrollment after 2022-12-01 and not graduated from Students
SELECT LastName, FirstName, EnrollmentDate, GraduationDate
  FROM Students
  WHERE EnrollmentDate > '2022-12-01' AND GraduationDate IS NULL;

-- EXERCISE 10 - return FullTimeCose, PerUnitCost, Units(12), TotalPerUnitCost, TotalTuition from Tuition
SELECT  FullTimeCost, PerUnitCost, 12 AS Units, (PerUnitCost * 12) AS TotalPerUnitCost, (FullTimeCost + (PerUnitCost * 12)) AS TotalTuition
  From Tuition;