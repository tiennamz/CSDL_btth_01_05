CREATE DATABASE bt_01_05;
USE bt_01_05;

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor_name VARCHAR(100) NOT NULL
);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT, 
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) 
);


CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    date_of_birth DATE
);


CREATE TABLE Grades (
    student_id INT,
    course_id INT,
    score FLOAT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) 
);


INSERT INTO Instructors (instructor_name) VALUES 
('Nguyen Van A'),
('Tran Thi B'),
('Le Van C');


INSERT INTO Courses (course_name, instructor_id) VALUES 
('Web Programming', 1),
('Database Systems', 2),
('Machine Learning', 3),
('Data Structures', NULL);


INSERT INTO Students (student_name, date_of_birth) VALUES 
('Doan Hai', '2005-08-15'),
('Le Mai', '2004-05-10'),
('Pham An', '2005-12-01'),
('Vuong Minh', '2003-10-22');


INSERT INTO Grades (student_id, course_id, score) VALUES 
(1, 1, 9.50), 
(2, 1, 8.00),
(3, 1, 7.50), 
(1, 2, 8.00), 
(4, 2, 6.50), 
(3, 4, NULL);

-- 1.	In ra danh sách tất cả Khóa học kèm theo tên giảng viên dạy khóa đó. Đảm bảo khóa học chưa có giảng viên vẫn phải xuất hiện trong báo cáo. 
SELECT 
	course_name,
	instructor_name
FROM courses c
LEFT JOIN instructors i
ON c.instructor_id = i.instructor_id;

-- 2.	Tìm danh sách sinh viên sinh năm 2005.
SELECT 
	student_name
FROM students
WHERE YEAR(date_of_birth) = '2005';

-- 3.	In ra bảng điểm của riêng môn "Lập trình Web" (Gồm: Tên SV, Mã SV, Điểm thi). Sắp xếp điểm từ cao xuống thấp.
SELECT 
	student_name,
	g.student_id,
    score
FROM grades g
INNER JOIN students s
ON g.student_id = s.student_id
INNER JOIN courses c
ON c.course_id = g.course_id
WHERE course_name = 'Web Programming'
ORDER BY score DESC;

-- 4.	In ra 1 báo cáo tổng hợp toàn trung tâm gồm: Tên Sinh Viên, Tên Khóa Học, và Tên Giảng Viên phụ trách khóa đó. 

SELECT 
s.student_name,
c.course_name,
i.instructor_name
FROM courses c
LEFT JOIN instructors i
ON c.instructor_id = i.instructor_id
INNER JOIN grades g
ON g.course_id = c.course_id
INNER JOIN students s
ON s.student_id =g.student_id


