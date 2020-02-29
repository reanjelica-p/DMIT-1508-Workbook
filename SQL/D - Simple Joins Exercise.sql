--Joins Exercise 1
USE [A01-School]
GO

-- We express relationships between tables in our design through FOREIGN KEY constraints.
-- But those constraints simply check/restrict information that is stored in the Foreign Key
-- column. It doesn't actually/physically 'connect' the tables- all tables are 'independent'.
-- That means that when we try to query information from multiple related tables, 
-- we have to state the connection between those tables. That is, we have to 
-- state how the tables JOIN together. 

--1.	Select Student full names and the course ID's they are registered in.
SELECT  FirstName + ' ' + LastName AS 'Full Name',
        CourseId
FROM    Student -- Start the FROM statement by identifying one of the tables you want
    INNER JOIN Registration -- Identify another table you are connecting to
        -- ON is where we specify which columns should be used in the relationship
        ON Student.StudentID = Registration.StudentID

--1.a. Select Student full names, the course ID and the course name that the students are registered in.
SELECT  FirstName + ' ' + LastName AS 'FullName',
        C.CourseId,
        CourseName
FROM    Student AS S
    INNER JOIN Registration AS R
        ON S.StudentID = R.StudentID -- ON helps us identify MATCHING data
    INNER JOIN Course AS C
        ON R.CourseId = C.CourseId

--2.	Select the Staff full names and the Course ID's they teach.
--      Order the results by the staff name then by the course Id
SELECT  DISTINCT -- The DISTINCT keyword will remove duplate rows from the results
        FirstName + ' ' + LastName AS 'Staff Full Name',
        CourseId
FROM    Staff S
    INNER JOIN Registration R
        ON S.StaffID = R.StaffID
ORDER BY 'Staff Full Name', CourseId

-- Alternate --
SELECT FirstName + ' ' + LastName AS 'Staff Full Name',
	   CourseID
FROM   Staff AS S
	INNER JOIN Registration AS R
	ON S.StaffID = R.StaffID
GROUP BY FirstName, LastName, CourseId
ORDER BY 'Staff Full Name', CourseId

--3.	Select all the Club ID's and the Student full names that are in them
SELECT  FirstName + ' ' + LastName AS 'Full Name',
        ClubId
FROM    Student 
    INNER JOIN Activity 
        ON Student.StudentID = Activity.StudentID

--4.	Select the Student full name, courseID's and marks for studentID 199899200.
SELECT FirstName + ' ' + LastName AS 'Full Name',
<<<<<<< HEAD
	   CourseId,
	   Marks
From   Student
		INNER JOIN Registration
			ON Registration.StudentID = Student.StudentID
			ON Registration.CourseId = Course.CourseId



/*
SELECT  S.FirstName + ' ' + S.LastName AS 'Student Name',
        R.CourseId,
        R.Mark
FROM    Registration R
    INNER JOIN Student S
            ON S.StudentID = R.StudentID
WHERE   S.StudentID = 199899200
*/
=======
	   CourseID,
	   Mark
FROM   Student
	INNER JOIN Registration
		ON Student.StudentID = Registration.StudentID
WHERE Student.StudentID = 199899200
>>>>>>> 49963b6958216948f905df9f5a8249dbefeda5fc

--5.	Select the Student full name, course names and marks for studentID 199899200.
SELECT FirstName + ' ' + LastName AS 'Full Name',
	   CourseName AS 'Course Name',
	   Mark
FROM Registration
	INNER JOIN Student
		ON Registration.StudentID = Student.StudentID
	INNER JOIN Course
		ON Registration.CourseID = Course.CourseID
WHERE Student.StudentID = 199899200

--6.	Select the CourseID, CourseNames, and the Semesters they have been taught in --StudentID 199899200?
SELECT FirstName + ' ' + LastName AS 'Full Name',
	   R.CourseID,
	   CourseName AS 'Course Name',
	   Semester
FROM Registration AS R
	INNER JOIN Student	
		ON R.StudentID = Student.StudentID
	INNER JOIN Course
		ON R.CourseID = Course.CourseID
WHERE Student.StudentID = 199899200

--7.	What Staff Full Names have taught Networking 1?
SELECT St.FirstName + ' ' + St.LastName AS 'Full Name',
		CourseName AS 'Course Name'
FROM Registration AS R
	INNER JOIN Course
		ON R.CourseID = Course.CourseID
	INNER JOIN Staff AS St
		ON St.StaffID = R.StaffID
WHERE CourseName LIKE '%Networking_1%'

--8.	What is the course list for student ID 199912010 in semester 2001S. Select the Students Full Name and the CourseNames
SELECT FirstName + ' ' + LastName AS 'Full Name',
	   CourseName AS 'Course Name'
FROM Registration AS R
	INNER JOIN Course
		ON R.CourseID = Course.CourseID
	INNER JOIN Student
		ON R.StudentID = Student.StudentID
WHERE R.StudentID = 199912010 AND R.Semester LIKE '%2001S%'

--9. What are the Student Names, courseID's with individual Marks at 80% or higher? Sort the results by course.
SELECT FirstName + ' ' + LastName As 'Full Name',
	   R.CourseID,
	   R.Mark
FROM Registration AS R
	INNER JOIN Student
		ON Student.StudentID = R.StudentId
	INNER JOIN Course
		On R.CourseID = Course.CourseID
WHERE R.Mark >= 80

--10. Modify the script from the previous question to show the Course Name along with the ID.
SELECT FirstName + ' ' + LastName As 'Full Name',
	   R.CourseID,
	   CourseName AS 'Course Name',
	   R.Mark
FROM Registration AS R
	INNER JOIN Student
		ON Student.StudentID = R.StudentId
	INNER JOIN Course
		On R.CourseID = Course.CourseID
WHERE R.Mark >= 80
