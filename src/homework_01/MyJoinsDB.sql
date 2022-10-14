/*
Задание 3+
Создайте базу данных с именем “MyJoinsDB”.
*/
drop database MyJoinsDB;
CREATE DATABASE MyJoinsDB;

CREATE TABLE MyJoinsDB.Task_06
(
    id         INT AUTO_INCREMENT NOT NULL,
    surnames   VARCHAR(30),
    name       VARCHAR(30),
    phone      VARCHAR(15),
    rating     DOUBLE(9,2),
    age        INT(11) NOT NULL,
    PRIMARY KEY (id)

);
drop table MyJoinsDB.Task_06;

/*
Задание 4+
В данной базе данных создайте 3 таблицы,
В 1-й таблице содержатся имена и номера телефонов сотрудников компании.
Во 2-й таблице содержатся ведомости о зарплате и должностях сотрудников: главный директор, менеджер, рабочий.
В 3-й таблице содержится информация о семейном положении, дате рождения, и месте проживания.
*/

-- В 1-й таблице содержатся имена и номера телефонов сотрудников компании.

CREATE TABLE MyJoinsDB.Employee -- работник
(
    id          INT AUTO_INCREMENT NOT NULL,
    surnamesN   VARCHAR(30)        NOT NULL,   -- Фамили
    nameN       VARCHAR(30)        NOT NULL,   -- Имя
    patronymicN VARCHAR(30) DEFAULT 'Unknown', -- Отчество
    phone       VARCHAR(20)        NOT NULL,   -- телефон
    PRIMARY KEY (id)
);

INSERT MyJoinsDB.Employee(nameN, patronymicN, surnamesN, phone)
VALUES ('Василий', 'Петрович', 'Лященко', '(091)7612343'),
       ('Зигмунд', 'Федорович', 'Унакий', '(092)7612343'),
       ('Олег', 'Евстафьевич', 'Выжлецов', '(093)7612343'),
       ('Виктор', 'Евстафьевич', 'Наглецов', '(094)7612343');
SELECT *
FROM MyJoinsDB.Employee;

-- TRUNCATE TABLE  MyJoinsDB.Employee;
-- DROP TABLE MyJoinsDB.Employee;

-- -----------------------------------------------------------------------

-- Во 2-й таблице содержатся ведомости о зарплате и должностях сотрудников: главный директор, менеджер, рабочий.
CREATE TABLE MyJoinsDB.workingPosition --  должность + зп
(
    -- id INT AUTO_INCREMENT NOT NULL,
    EmployeeIDPosition INT         not null,
    jobTitle           VARCHAR(30) NOT NULL, -- Должность
    salary             double      NOT NULL, -- Зарлата
    FOREIGN KEY (EmployeeIDPosition) references Employee (id),
    PRIMARY KEY (EmployeeIDPosition)
);

INSERT INTO MyJoinsDB.workingPosition
    (EmployeeIDPosition, jobTitle, salary)
VALUES (1, 'главный директор', 150000.00),
       (2, 'менеджер', 120000.00),
       (3, 'рабочий', 100000.00),
       (4, 'менеджер', 100000.00);
SELECT *
FROM MyJoinsDB.workingPosition;

-- TRUNCATE TABLE  MyJoinsDB.workingPosition;
-- DROP TABLE MyJoinsDB.workingPosition;
-- -----------------------------------------------------------------------
-- 3-й таблице содержится информация о семейном положении, дате рождения, и месте проживания.
CREATE TABLE MyJoinsDB.workingStatus
(
    EmployeeID INT          not null,
    statusF    VARCHAR(30)  NOT NULL, -- семейном положении
    dateBirth  DATE         NOT NULL, -- дата рождения
    address    VARCHAR(100) NOT NULL, -- месте проживания.
    FOREIGN KEY (EmployeeID) references Employee (id),
    PRIMARY KEY (EmployeeID)
);

INSERT INTO MyJoinsDB.workingStatus
    (EmployeeID, statusF, dateBirth, address)
VALUES (1, 'не женат', '1981-11-11', 'Ул Плюшкина / 1'),
       (2, 'женат', '1982-11-11', 'Ул Плюшкина / 2'),
       (3, 'не женат', '1983-11-11', 'Ул Плюшкина / 3'),
       (4, 'женат', '1984-11-11', 'Ул Плюшкина / 4');
SELECT *
FROM MyJoinsDB.workingStatus;

-- TRUNCATE TABLE  MyJoinsDB.workingStatus;
-- DROP TABLE MyJoinsDB.workingStatus;

/*
Задание 4
Сделайте выборку при помощи JOIN’s для таких заданий:
1) Получите контактные данные сотрудников (номера телефонов, место жительства).
2) Получите информацию о дате рождения всех холостых сотрудников и их номера.
3) Получите информацию обо всех менеджерах компании: дату рождения и номер телефона.
*/

-- 1) Получите контактные данные сотрудников (номера телефонов, место жительства).
SELECT phone, address
FROM MyJoinsDB.Employee
         JOIN MyJoinsDB.workingStatus ON id = EmployeeID;

-- 2) Получите информацию о дате рождения всех холостых сотрудников и их номера.
SELECT dateBirth, phone
FROM MyJoinsDB.Employee
         JOIN MyJoinsDB.workingStatus ON statusF = 'не женат' and id = EmployeeID;

-- 3) Получите информацию обо всех менеджерах компании: дату рождения и номер телефона.
SELECT phone, dateBirth
FROM MyJoinsDB.Employee
         JOIN MyJoinsDB.workingPosition ON jobTitle = 'менеджер' and id = EmployeeIDPosition
         JOIN MyJoinsDB.workingStatus ON id = EmployeeID;
