---part 1  Warm-Up
--1
SELECT CourseID, Title as CourseName , Price FROM Courses;

--2
SELECT StudentID, FullName as StudentName, JoinDate FROM Students;

--3 
SELECT EnrollmentID, CompletionPercent, Rating FROM Enrollments;

--4
SELECT COUNT(*) AS InstructorCount FROM Instructors WHERE YEAR(JoinDate) = 2023;

--5
SELECT COUNT(*) AS StudentCount FROM Students WHERE YEAR(JoinDate) = 2023 AND MONTH(JoinDate) = 4;


--- Part 2: Beginner Aggregation
---1 
SELECT COUNT(*) FROM Students;

---2
SELECT COUNT(*) FROM Enrollments;

---3 
SELECT  CourseID,  AVG(Rating) AS AvgRating FROM Enrollments GROUP BY CourseID;

--4

SELECT i.FullName as instructor_name  , COUNT(c.CourseID) AS CourseCount FROM Instructors i LEFT JOIN Courses c ON i.InstructorID = c.InstructorID GROUP BY i.FullName;

---5
SELECT cat.CategoryName,COUNT(c.CourseID) AS CourseCount FROM Categories cat LEFT JOIN Courses c ON cat.CategoryID = c.CategoryID GROUP BY cat.CategoryName;

---6
SELECT  c.Title  as CourseName,COUNT(e.StudentID) AS StudentCount FROM Courses c LEFT JOIN Enrollments e ON c.CourseID = e.CourseID GROUP BY c.Title;

----7
SELECT cat.CategoryName, AVG(c.Price) AS AvgPrice FROM Categories cat LEFT JOIN Courses c ON cat.CategoryID = c.CategoryID GROUP BY cat.CategoryName;


--8
SELECT MAX(Price) AS MaxPrice FROM Courses;


--9 
SELECT c.Title as CourseName, MIN(e.Rating) AS MinRating, MAX(e.Rating) AS MaxRating, AVG(e.Rating) AS AvgRating FROM Enrollments e JOIN Courses c ON e.CourseID = c.CourseID GROUP BY c.Title;


--10
SELECT COUNT(*) AS FiveStarCount FROM Enrollments WHERE Rating = 5;



----Part 3: Extended Beginner Practice
----1 
SELECT YEAR(EnrollDate) AS Year,MONTH(EnrollDate) AS Month,COUNT(*) AS EnrollmentCount FROM Enrollments GROUP BY YEAR(EnrollDate), MONTH(EnrollDate)

---2
SELECT AVG(Price) AS AvgCoursePrice FROM Courses;

---3
SELECT YEAR(JoinDate) AS Year,MONTH(JoinDate) AS Month,COUNT(*) AS StudentCount FROM Students GROUP BY YEAR(JoinDate), MONTH(JoinDate) 

---4 
SELECT Rating,COUNT(*) AS RatingCount FROM Enrollments GROUP BY Rating 


---5
SELECT Title as CourseName FROM Courses WHERE CourseID NOT IN (SELECT CourseID FROM Enrollments WHERE Rating = 5);


---6

SELECT COUNT(*) AS CoursesAbove30 FROM Courses WHERE Price > 30;


---7
SELECT AVG(CompletionPercent) AS AvgCompletion FROM Enrollments;

----8

SELECT TOP 1 c.Title as CourseName,AVG(e.Rating) AS AvgRating FROM Courses c JOIN Enrollments e ON c.CourseID = e.CourseID GROUP BY c.Title 



----Course Performance Snapshot


SELECT 
    c.Title ,
    COUNT(e.EnrollmentID) AS TotalEnrollments,
    AVG(e.Rating) AS AverageRating,
    AVG(e.CompletionPercent) AS AverageCompletion
FROM Courses c
LEFT JOIN Enrollments e 
    ON c.CourseID = e.CourseID
GROUP BY c.Title;


---- JOIN + Aggregation + Analysis


SELECT 
    c.Title,
    COUNT(e.EnrollmentID) AS TotalEnrollments,
    ROUND(AVG(e.Rating), 2) AS AverageRating,
    ROUND(AVG(e.CompletionPercent), 2) AS AverageCompletion
FROM Courses c
JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.Title
HAVING 
    COUNT(e.EnrollmentID) >= 2
    AND AVG(e.Rating) >= 4;


	----Part 4: JOIN + Aggregation

	--1 
	SELECT
    c.Title,
    i.FullName as InstructorName,
    COUNT(e.EnrollmentID) AS TotalEnrollments
FROM Courses c
JOIN Instructors i
    ON c.InstructorID = i.InstructorID
LEFT JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    c.Title,
    i.FullName	;

	---2
	SELECT
    cat.CategoryName,
    COUNT(c.CourseID) AS TotalCourses,
    ROUND(AVG(c.Price), 2) AS AveragePrice
FROM Categories cat
LEFT JOIN Courses c
    ON cat.CategoryID = c.CategoryID
GROUP BY
    cat.CategoryName;


---3
	
	SELECT
    i.FullName as InstructorName,
    ROUND(AVG(CAST(e.Rating AS DECIMAL(10,2))), 2) AS AverageCourseRating
FROM Instructors i
JOIN Courses c
    ON i.InstructorID = c.InstructorID
JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    i.FullName;






	---4 
	SELECT
    s. FullName as StudentName,
    COUNT(e.CourseID) AS TotalCoursesEnrolled
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID
GROUP BY
    s.FullName;








	----5

	SELECT
    cat.CategoryName,
    COUNT(e.EnrollmentID) AS TotalEnrollments
FROM Categories cat
JOIN Courses c
    ON cat.CategoryID = c.CategoryID
LEFT JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    cat.CategoryName;



	---6
	SELECT
    i.FullName as InstructorName,
    ROUND(SUM(CAST(c.Price AS DECIMAL(10,2))), 2) AS TotalRevenue
FROM Instructors i
JOIN Courses c
    ON i.InstructorID = c.InstructorID
JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    i.FullName;


	---7
	SELECT
    c.Title as CourseTitle,
    CASE 
        WHEN COUNT(e.EnrollmentID) = 0 THEN 0
        ELSE ROUND(
            100.0 * SUM(CASE WHEN e.CompletionPercent = 100 THEN 1 ELSE 0 END) 
            / COUNT(e.EnrollmentID), 2)
    END AS PercentCompleted100
FROM Courses c
LEFT JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    c.Title ;



----Part 5: HAVING Practice

---1 
SELECT
    c.Title as CourseTitle,
    COUNT(e.EnrollmentID) AS TotalEnrollments
FROM Courses c
JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    c.Title
HAVING
    COUNT(e.EnrollmentID) > 2;

	---2
SELECT
    i. FullName as InstructorName,
    AVG(e.Rating) AS AverageRating
FROM Instructors i
JOIN Courses c
    ON i.InstructorID = c.InstructorID
JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    i. FullName
HAVING
    AVG(e.Rating) > 4;

----3 
SELECT
    c.Title as CourseTitle,
    AVG(e.CompletionPercent) AS AvgCompletion
FROM Courses c
JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    c.Title
HAVING
    AVG(e.CompletionPercent) < 60;


---4

SELECT
    cat.CategoryName,
    COUNT(c.CourseID) AS TotalCourses
FROM Categories cat
JOIN Courses c
    ON cat.CategoryID = c.CategoryID
GROUP BY
    cat.CategoryName
HAVING
    COUNT(c.CourseID) > 1;

	---5
	SELECT
    s.FullName as StudentName,
    COUNT(e.CourseID) AS CoursesEnrolled
FROM Students s
JOIN Enrollments e
    ON s.StudentID = e.StudentID
GROUP BY
    s.FullName
HAVING
    COUNT(e.CourseID) >= 2;




	---- Part 6: Analytical Thinking

-----1
SELECT TOP 1
    c.Title as CourseTitle,
    AVG(e.Rating) AS AvgRating
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY AvgRating DESC;

------Explanation: Finds the course with the highest average student rating.

---2
SELECT TOP 1
    i.FullName as InstructorName,
    AVG(e.Rating) AS AvgRating
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName 
ORDER BY AvgRating DESC;

-----Explanation: Instructor with the best overall course ratings.
----3
SELECT TOP 1
    cat.CategoryName,
    SUM(c.Price) AS TotalRevenue
FROM Categories cat
JOIN Courses c ON cat.CategoryID = c.CategoryID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName
ORDER BY TotalRevenue DESC;
------Explanation: Category generating the most revenue.

----4
SELECT c.Title, c.Price, AVG(e.Rating) AS AvgRating
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title, c.Price
ORDER BY c.Price DESC;

-----no ,There is no relationship between them


---5 
SELECT c.Title, c.Price, AVG(e.CompletionPercent) AS AvgCompletion
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title, c.Price
ORDER BY c.Price ASC;
----yes 

-----Final Challenge – Mini Analytics Report
---1

SELECT TOP 3
    c.Title as CourseTitle,
    SUM(c.Price) AS Revenue
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY Revenue DESC;


----2
SELECT TOP 1
    i.FullName as InstructorName,
    COUNT(e.EnrollmentID) AS TotalEnrollments
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
ORDER BY TotalEnrollments DESC;

---3
SELECT TOP 1
    c.Title as CourseTitle,
    AVG(e.CompletionPercent) AS AvgCompletion
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.Title
ORDER BY AvgCompletion ASC;

----4
SELECT TOP 1
    cat.CategoryName,
    AVG(e.Rating) AS AvgRating
FROM Categories cat
JOIN Courses c ON cat.CategoryID = c.CategoryID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY cat.CategoryName
ORDER BY AvgRating DESC;


-----5
SELECT TOP 1
    s.FullName as StudentName,
    COUNT(e.CourseID) AS TotalCourses
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.FullName 
ORDER BY TotalCourses DESC;



