USE [A01-School]
GO

-- 1. Create a stored procedure called StudentClubCount. It will accept a clubID as a parameter. 
-- If the count of students in that club is greater than 2 print ‘A successful club!’ . If the count is not greater than 2 print ‘Needs more members!’.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'StudentClubCount')
    DROP PROCEDURE StudentClubCount
GO
Create Procedure StudentClubCount
	@ClubID varchar
AS
	Declare @studentIDcount int = 0
	Select @studentIDcount = Count(StudentID)
	From Activity
	Where @ClubID = ClubID
	If @ClubID IS NULL
		RAISERROR('All parameters are required.', 16, 1)
	Else If NOT EXISTS (Select ClubID From Club Where ClubID = @ClubID)
		RAISERROR('Club is non-existent.', 16, 1)
	Else If @studentIDcount > 2
		Print('A successful club!')
	Else
		Print ('Needs more members!')
GO
--Test data
EXEC StudentClubCount 'CSS'
EXEC StudentClubCount ''
EXEC StudentClubCount 'LOL'

--2. Create a stored procedure called BalanceOrNoBalance. It will accept a studentID as a parameter. 
-- Each course has a cost. If the total of the costs for the courses the student is registered in is more than the total of the payments that student has made  then print ‘balance owing !’ otherwise print ‘Paid in full! Welcome to School 158!’
-- Do not use the BalanceOwing field in your solution. 
/*
SELECT * FROM Student
SELECT * FROM Payment

Select C.CourseID,
	   CourseName,
	   Sum(CourseCost) as 'Total due',
	   StudentID
From Registration as R
	INNER JOIN Course as C
		ON R.CourseID = C.CourseID
Group By StudentID, C.CourseID, CourseName

Select --C.CourseID,
	   --CourseName,
	   Sum(CourseCost) as 'Total due',
	   StudentID
From Registration as R
	INNER JOIN Course as C
		ON R.CourseID = C.CourseID
Group By StudentID --C.CourseID, CourseName
*/

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'BalanceOrNoBalance')
    DROP PROCEDURE BalanceOrNoBalance
GO
Create Procedure BalanceOrNoBalance
	@StudentID int
AS
	Declare @studentamount int = 0,
			@totalcost int = 0
	Select @studentamount = P.Amount,
		   @totalcost = Sum(CourseCost)
	From Registration as R
		INNER JOIN Course as C
			ON C.CourseID = R.CourseID
		INNER JOIN Payment as P
			ON P.StudentID = R.StudentID
	Where R.StudentID = @StudentID
	Group By P.Amount
	If @StudentID IS NULL
		RAISERROR('All parameters are required.', 16, 1)
	Else If NOT EXISTS (Select StudentID From Registration Where StudentID = @StudentID)
		RAISERROR('Student is non-existent.', 16, 1)
	Else If (@studentamount >= @totalcost)
		Print ('Paid in full! Welcome to School 158!')
	Else
		Print ('Balance owing!')
GO
EXEC BalanceOrNoBalance 200494470
EXEC BalanceOrNoBalance 000000000

--3. Create a stored procedure called ‘DoubleOrNothin’. It will accept a students first name and last name as parameters. 
-- If the student name already is in the table then print ‘We already have a student with the name firstname lastname!’ 
-- Other wise print ‘Welcome firstname lastname!’



