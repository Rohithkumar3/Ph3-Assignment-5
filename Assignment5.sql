create database Assignment5
use Assignment5

create schema bank
CREATE TABLE bank.Customer (
    CId INT PRIMARY KEY identity (1000,1) NOT NULL,
    CName nvarchar(50) not null ,
    CEmail nvarchar(50) UNIQUE not null ,
	Contact varchar (10) not null unique check (contact like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CPwd as	 CONCAT(SUBSTRING(CName, LEN(CName) - 1, 2), 
   SUBSTRING(CAST(Cid AS VARCHAR),
   LEN(CAST(Cid AS VARCHAR)) - 1, 2), 
   SUBSTRING(contact, 1, 2))  Persisted   
)

select * from bank.Customer

CREATE TABLE bank.Mailinfo (
    MailTo nvarchar(MAX) NOT NULL,
    MailDate DATE NOT NULL,
    MailMessage nvarchar(MAX) NOT NULL
)

CREATE TRIGGER bank.trgMailToCust
ON bank.Customer
AFTER INSERT
AS
BEGIN
    INSERT INTO bank.Mailinfo (MailTo, MailDate, MailMessage)
    SELECT CEmail, GETDATE(), 'Your net banking password is: ' + CPWD + ' It is valid up to 2 days only. Update It'
    FROM inserted;
END

INSERT INTO bank.Customer (CName, CEmail, Contact) VALUES
('Rohithkumar', 'rohith@gmail.com', '1234567890'),
('Kiran', 'kiran@email.com', '9731248650'),
('Rahul', 'rahul@gmail.com', '1262489706');

select * from bank.Customer
select * from bank.Mailinfo

