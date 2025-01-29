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

--EXERCISE 8 - return InstructorDepartment, LastName, FirstName, CourseDescription, CourseDept 
-- from Departments, Instructors, Courses 
-- 1 row for each course where instr dept differs from course dept
-- Tables: Departments (8), Instructors (16), Courses (25)
-- Courses -> Departments, Courses->Instructor, Instructors -> Deptartments
SELECT DepartmentName AS InstructorDept, LastName, FirstName, CourseDescription, DepartmentName AS CourseDept
  FROM Departments D
  JOIN Instructors I ON D.DepartmentID = I.DepartmentID
  JOIN Courses C ON I.InstructorID = C.InstructorID
  Where InstructorDept != CourseDept;

--IN CLASS SOLUTION
SELECT CourseDescription, D1.DepartmentName AS CourseDept, D2.DepartmentName AS InstructorDept,
       LastName + ', ' + FirstName AS InstructorName
  FROM Courses C
  JOIN Departments D1 ON C.DepartmentID = D1.DepartmentID
  JOIN Instructors I ON C.InstructorID = I.InstructorID
  JOIN Departments D2 ON I.DepartmentID = D2.DepartmentID
  WHERE D1.DepartmentID != D2.DepartmentID;

  --OUTER JOIN EXAMPLE Any instructors who aren't assigned a course? 
 SELECT LastName + ', ' + FirstName AS InstructorName, CourseDescription
   FROM Instructors I
   LEFT JOIN Courses C ON I.InstructorID = C.InstructorID
   WHERE CourseDescription IS NULL;


--CHAPTER 5
--EXERCISE 1 return count of number of instructors and average salary
-- for fulltime instructors
SELECT Count(*) AS NumberOfInstructors, 
       AVG(AnnualSalary) AS AvgSalary
  FROM Instructors
  WHERE Status LIKE '[F]%';

--EXERCISE 2  return Department name, NumberOfInstructors, HighestPaid, sort descending
SELECT DepartmentName, COUNT(*) AS NumberofInstructors, MAX(AnnualSalary) AS HighestPaid
  FROM Instructors I
  JOIN Departments D ON D.DepartmentID = I.DepartmentID
  GROUP BY DepartmentName
  ORDER BY NumberofInstructors DESC;

--EXERCISE 3 - return intructor's full name(First Last), Number of courses for each instructor, sum of course units for each instructor
--sort in descending order by course units
SELECT (FirstName + ' ' + LastName) AS InstructorName, COUNT(*) AS InstructorCourses, SUM(CourseUnits) AS CourseUnits
  FROM Instructors I
  JOIN Courses C ON I.InstructorID = C.InstructorID
  GROUP BY (FirstName + ' ' + LastName)
  ORDER BY CourseUnits DESC;

--EXERCISE 4 - return 1 row for each couse that has student enrolled
--DepartmentName CourseDescription, #of students in course
SELECT DepartmentName, CourseDescription, COUNT(*) Enrollment
  FROM Departments D
  JOIN Courses C on D.DepartmentID = c.DepartmentID
  JOIN StudentCourses S ON C.CourseID = S.CourseID
  GROUP BY DepartmentName, CourseDescription
  ORDER BY DepartmentName, Enrollment;

--EXERCISE 5 - return one row for each student that has courses
-- StudentID, sum of course units - descending by total course units
SELECT S.StudentID, SUM(CourseUnits) AS StudentUnits
  FROM Students S
  JOIN StudentCourses SC ON S.StudentID = SC.StudentID
  JOIN Courses C ON SC.CourseID = C.CourseID
  GROUP BY s.StudentID
  ORDER BY StudentUnits DESC;

--EXERCISE 6 - Modify the solution to exercise 5 so it only includes students who haven’t graduated 
--and who are taking more than nine units.
SELECT S.StudentID, SUM(CourseUnits) AS StudentUnits
  FROM Students S
  JOIN StudentCourses SC ON S.StudentID = SC.StudentID
  JOIN Courses C ON SC.CourseID = C.CourseID
  WHERE S.GraduationDate IS NULL
  GROUP BY s.StudentID
  HAVING SUM(CourseUnits) >9 
  ORDER BY StudentUnits DESC;

 --EXERCISE 7 -  What is the total number of courses taught by part-time instructors only?
 -- return (LastName,FirstName), total courses by each instructor
 SELECT (LastName + ', ' + FirstName) AS InstructorName, Count(*) as TotalCourses
   FROM Instructors I
   JOIN Courses C ON I.InstructorID = c.InstructorID
   WHERE Status LIKE '[P]%'
   GROUP BY ROLLUP(LastName + ', ' + FirstName);

--CHAPTER 6
--EXERCISE 1 - Write a SELECT statement that returns the same result set as this SELECT 
--statement, but don’t use a join. Instead, use a subquery in a WHERE clause that uses 
--the IN keyword
SELECT DISTINCT LastName, FirstName
FROM Instructors i
 JOIN Courses c
 ON i.InstructorID = c.InstructorID
ORDER BY LastName, FirstName

