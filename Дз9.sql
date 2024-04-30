--��� 0 �������� ��
use [master];
go

if db_id('Academy') is not null
begin
	drop database [Academy];
end
go

create database [Academy];
go

use [Academy];
go

create table [Curators]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

create table [Departments]
(
	[Id] int not null identity(1, 1) primary key,
	[Building] int not null check ([Building] between 1 and 5),
	[Financing] money not null check ([Financing] >= 0.0) default 0.0,
	[Name] nvarchar(100) not null unique check ([Name] <> N''),
	[FacultyId] int not null
);
go

create table [Faculties]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Groups]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N''),
	[Year] int not null check ([Year] between 1 and 5),
	[DepartmentId] int not null
);
go

create table [GroupsCurators]
(
	[Id] int not null identity(1, 1) primary key,
	[CuratorId] int not null,
	[GroupId] int not null
);
go

create table [GroupsLectures]
(
	[Id] int not null identity(1, 1) primary key,
	[GroupId] int not null,
	[LectureId] int not null
);
go

create table [GroupsStudents]
(
	[Id] int not null identity(1, 1) primary key,
	[GroupId] int not null,
	[StudentId] int not null
);
go

create table [Lectures]
(
	[Id] int not null identity(1, 1) primary key,
	[Date] date not null check ([Date] <= getdate()),
	[SubjectId] int not null,
	[TeacherId] int not null
);
go

create table [Students]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Rating] int not null check ([Rating] between 0 and 5),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

create table [Subjects]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Teachers]
(
	[Id] int not null identity(1, 1) primary key,
	[IsProfessor] bit not null default 0,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Salary] money not null check ([Salary] > 0.0),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

alter table [Departments]
add foreign key ([FacultyId]) references [Faculties]([Id]);
go

alter table [Groups]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

alter table [GroupsCurators]
add foreign key ([CuratorId]) references [Curators]([Id]);
go

alter table [GroupsCurators]
add foreign key ([GroupId]) references [Groups]([Id]);
go

alter table [GroupsLectures]
add foreign key ([GroupId]) references [Groups]([Id]);
go

alter table [GroupsLectures]
add foreign key ([LectureId]) references [Lectures]([Id]);
go

alter table [GroupsStudents]
add foreign key ([GroupId]) references [Groups]([Id]);
go

alter table [GroupsStudents]
add foreign key ([StudentId]) references [Students]([Id]);
go

alter table [Lectures]
add foreign key ([SubjectId]) references [Subjects]([Id]);
go

alter table [Lectures]
add foreign key ([TeacherId]) references [Teachers]([Id]);
go
--��� 1 ��������� �������� � �������

-- ��������� ����������
INSERT INTO Faculties (Name) VALUES
('Computer Science'),
('Information Technology'),
('Engineering'),
('Mathematics'),
('Physics');

SELECT * FROM Faculties

-- ��������� ������� � ������� ������� ��������������
INSERT INTO Departments (Building, Financing, Name, FacultyId) VALUES
(1, 200000.00, 'Software Development', 1),
(2, 150000.00, 'System Analysis', 2),
(3, 50000.00, 'Applied Mathematics', 4),
(4, 80000.00, 'Physics of Microworld', 5),
(5, 3220000.00, 'Quantum Physics', 5);

SELECT * FROM Departments

-- ��������� ������ � ��������� �� ����� � �������
INSERT INTO Groups (Name, Year, DepartmentId) VALUES
('D221', 5, 1),
('SA441', 4, 2),
('AM321', 3, 3),
('PM521', 2, 4),
('QP111', 1, 5);

SELECT * FROM Departments

-- ��������� ���������
INSERT INTO Curators (Name, Surname) VALUES
('����', '������'),
('����', '������'),
('�����', '��������'),
('�����', '���������'),
('������', '������');

SELECT * FROM Curators

-- ��������� ��������� ������� (������ ������ �����)
INSERT INTO GroupsCurators (CuratorId, GroupId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2); -- ���� ������ ����� ������� SA441

SELECT * FROM GroupsCurators

-- ��������� �������� (����������)
INSERT INTO Subjects (Name) VALUES
('Programming'),
('Data Analysis'),
('Linear Algebra'),
('Quantum Mechanics'),
('Electrodynamics');

SELECT * FROM Subjects

-- ��������� ��������������
INSERT INTO Teachers (IsProfessor, Name, Salary, Surname) VALUES
(1, '���������', 90000.00, '�������'),
(0, '�����', 50000.00, '���������'),
(1, '�������', 100000.00, '�����'),
(0, '�������', 45000.00, '�������'),
(1, '�����', 110000.00, '��������');

SELECT * FROM Teachers

-- ��������� ������ � ��������� �������� � �������������
INSERT INTO Lectures (Date, SubjectId, TeacherId) VALUES
('2023-03-20', 1, 1),
('2023-03-21', 2, 2),
('2023-03-22', 3, 3),
('2023-03-23', 4, 4),
('2023-03-24', 5, 5);

SELECT * FROM Lectures

-- ���������� ������ ��� �����
INSERT INTO GroupsLectures (GroupId, LectureId) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5);

SELECT * FROM GroupsLectures

-- ��������� ��������� � ������� ����������
INSERT INTO Students (Name, Rating, Surname) VALUES
('������', 5, '�����'),
('������', 4, '��������'),
('��������', 3, '�������'),
('������', 2, '��������'),
('����', 1, '�������');

SELECT * FROM Students

-- ����������� ��������� � �������
INSERT INTO GroupsStudents (GroupId, StudentId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),
(1, 3),
(1, 4),
(1, 5); -- �������������� �������� ��� ������ D221

SELECT * FROM GroupsStudents

-- ��� 2 �������

--1. ������� ������ ��������, ���� ��������� ���� �������-
--������� ������������� � ��� ������ ��������� 100000.
SELECT DISTINCT d.Building
FROM Departments d
WHERE (SELECT SUM(Financing) FROM Departments WHERE Building = d.Building) > 100000;


--2. ������� �������� ����� 5-�� ����� ������� �Software
--Development�, ������� ����� ����� 10 ��� � ������ ������.
SELECT g.Name
FROM Groups g
JOIN Departments d ON g.DepartmentId = d.Id
WHERE d.Name = 'Software Development' AND g.Year = 5
AND (SELECT COUNT(*) FROM GroupsLectures gl WHERE gl.GroupId = g.Id) > 10;

--3. ������� �������� �����, ������� ������� (������� ���-
--���� ���� ��������� ������) ������, ��� ������� ������
--�D221�.
SELECT g.Name
FROM Groups g
WHERE (SELECT AVG(Rating) FROM Students s JOIN GroupsStudents gs ON s.Id = gs.StudentId WHERE gs.GroupId = g.Id)
> (SELECT AVG(Rating) FROM Students s JOIN GroupsStudents gs ON s.Id = gs.StudentId WHERE gs.GroupId = (SELECT Id FROM Groups WHERE Name = 'D221'));

--4. ������� ������� � ����� ��������������, ������ �������
--���� ������� ������ �����������.
SELECT t.Surname, t.Name
FROM Teachers t
WHERE t.Salary > (SELECT AVG(Salary) FROM Teachers WHERE IsProfessor = 1);

--5. ������� �������� �����, � ������� ������ ������ ��������.
SELECT g.Name
FROM Groups g
WHERE (SELECT COUNT(*) FROM GroupsCurators gc WHERE gc.GroupId = g.Id) > 1;

--6. ������� �������� �����, ������� ������� (������� ���-
--���� ���� ��������� ������) ������, ��� �����������
--������� ����� 5-�� �����.
SELECT g.Name
FROM Groups g
WHERE (SELECT AVG(Rating) FROM Students s JOIN GroupsStudents gs ON s.Id = gs.StudentId WHERE gs.GroupId = g.Id)
< (SELECT MIN(sub.avgRating) FROM (SELECT AVG(Rating) as avgRating FROM Students s JOIN GroupsStudents gs ON s.Id = gs.StudentId JOIN Groups gr ON gs.GroupId = gr.Id WHERE gr.Year = 5 GROUP BY gr.Id) sub);

--7. ������� �������� �����������, ��������� ���� �����-
--��������� ������ ������� ������ ���������� �����
--�������������� ������ ���������� �Computer Science�.
SELECT f.Name
FROM Faculties f
WHERE (SELECT SUM(Financing) FROM Departments d WHERE d.FacultyId = f.Id)
> (SELECT SUM(Financing) FROM Departments d JOIN Faculties f ON d.FacultyId = f.Id WHERE f.Name = 'Computer Science');

--8. ������� �������� ��������� � ������ ����� ���������-
--�����, �������� ���������� ���������� ������ �� ���.
SELECT sub.Name, (SELECT t.Name FROM Teachers t WHERE t.Id = sub.TeacherId) as TeacherName, (SELECT t.Surname FROM Teachers t WHERE t.Id = sub.TeacherId) as TeacherSurname
FROM (SELECT s.Name, l.TeacherId, COUNT(*) as LectureCount FROM Lectures l JOIN Subjects s ON l.SubjectId = s.Id GROUP BY s.Name, l.TeacherId) sub
WHERE sub.LectureCount = (SELECT MAX(subsub.LectureCount) FROM (SELECT COUNT(*) as LectureCount FROM Lectures l GROUP BY l.SubjectId) subsub);

--9. ������� �������� ����������, �� �������� ��������
--������ ����� ������.
SELECT s.Name
FROM Subjects s
WHERE (SELECT COUNT(*) FROM Lectures l WHERE l.SubjectId = s.Id) = (SELECT MIN(sub.LectureCount) FROM (SELECT COUNT(*) as LectureCount FROM Lectures GROUP BY SubjectId) sub);

--10. ������� ���������� ��������� � �������� ��������� ��
--������� �Software Development�.
SELECT 
(SELECT COUNT(*) FROM Students s JOIN GroupsStudents gs ON s.Id = gs.StudentId JOIN Groups g ON gs.GroupId = g.Id JOIN Departments d ON g.DepartmentId = d.Id WHERE d.Name = 'Software Development') as StudentCount,
(SELECT COUNT(DISTINCT l.SubjectId) FROM Lectures l JOIN Subjects s ON l.SubjectId = s.Id JOIN Teachers t ON l.TeacherId = t.Id JOIN Departments d ON s.Id = d.Id WHERE d.Name = 'Software Development') as SubjectCount;


