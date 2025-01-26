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

--CHAPTER 4
--EXERCISE 1 - return DepartmentName, CourseNumber, CourseDescription from Courses and Departments - sort by CourseNumber then DepartmentName ascending
Select DepartmentName, CourseNumber, CourseDescription
  FROM Departments D
  JOIN Courses C ON d.DepartmentID = c.DepartmentID
  ORDER BY DepartmentName, CourseNumber;

--EXERCISE 2 - return LastName, FirstName, CourseNumber, CourseDescription
SELECT LastName, FirstName, CourseNumber, CourseDescription
  FROM Instructors I
  JOIN Courses C on I.DepartmentID = C.DepartmentID
  WHERE I.Status LIKE '[P]%'
  ORDER BY LastName, FirstName;

--EXERCISE 3_ return DepartmentName, CourseDescription, FirstName, LastName -  from Departments, Courses, & Instructors - only courses with 3 units - sort by Dept then Course
SELECT DepartmentName, CourseDescription, FirstName, LastName
  FROM Departments D
  JOIN Courses C ON D.DepartmentID = C.DepartmentID
  JOIN Instructors I on C.InstructorID = C.InstructorID
  WHERE CourseUnits = 3
  ORDER BY DepartmentName, CourseDescription;
   
--EXERCISE 4 - return DepartmentName, CourseDescription, LastName, FirstName - in English dept - from Departments, Courses, Instructors - sort by CourseDescription
SELECT *
  FROM Courses C
  JOIN Departments D ON C.DepartmentID = D.DepartmentID
  JOIN Instructors I ON C.DepartmentID = I.DepartmentID
  WHERE DepartmentName = 'ENGLISH'
  ORDER BY CourseDescription;
  
--EXERCISE 5 - return LastName, FirstName, CourseDescription from Intructors and Courses - sort by last/ first
SELECT LastName, FirstName, CourseDescription
  FROM Instructors I
  Join Courses C ON I.InstructorID = C.InstructorID
  WHERE CourseUnits >= 0
  ORDER BY LastName, FirstName;

--EXERCISE 6 - Skipped due to Union

--EXERCISE 7 - return DepartmentName, CourseID - return depts with no courses - from Departments and Courses - outer join
SELECT DepartmentName, CourseID
  From Departments D
  LEFT JOIN Courses C ON D.DepartmentID = c.DepartmentID
  Where CourseID IS NULL;

--EXERCISE 8 - return InstructorDepartment, LastName, FirstName, CourseDescription, CourseDept - from Departments, Instructors, Courses - 1 row for each course where instr dept differs from course dept
SELECT DepartmentName AS InstructorDept, LastName, FirstName, CourseDescription, DepartmentName AS CourseDept
  FROM Departments D
  JOIN Instructors I ON D.DepartmentID = I.DepartmentID
  JOIN Courses C ON I.InstructorID = C.InstructorID
  Where InstructorDept != CourseDept;