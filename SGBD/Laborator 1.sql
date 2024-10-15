-- 1
-- X a F
-- b A
-- c F
--
-- 2
-- X a F
-- b A
-- c F
-- d A
--
-- 3
-- a A
-- b A
-- c F
-- d A
--
-- 4
-- a F
-- b F
-- c A
-- d A
--
-- 5
-- ? a F
-- ? b A
-- X c A
-- X d F
--
-- 6
-- X a A
-- b F
-- X c F
-- X d F
--
-- 7
-- X a A
-- b F
-- c F
-- X d F
--
-- 8
-- a F
-- b F
-- c A
-- d F
--
-- 9
-- a
-- b
-- c
-- d
--
-- 10
-- a F
-- b F
-- X c F
-- X d A




create table emp_ao as select * from employees;

comment on table emp_ao is 'Comentariul meu';
comment on column emp_ao.salary is 'Acesta este salariul angajatilor';

select * from emp_ao;

select *
from USER_TAB_COMMENTS
where table_name = 'EMP_AO';

select *
from USER_COL_COMMENTS
where table_name = 'EMP_AO' and column_name = 'SALARY';


-- Update comentariu
comment on table emp_ao is 'Comentariul meu 2';
comment on column emp_ao.salary is 'Acesta este salariul angajatilor 2';

-- Stergere comentariu
comment on table emp_ao is '';
comment on column emp_ao.salary is '';


-- Exercitiul 13
ALTER SESSION SET NLS_DATE_FORMAT  = 'dd.mm.yyyy hh24:mi:ss';

select sysdate from dual;


-- Exercitiul 14
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;


-- Exercitiul 15
SELECT EXTRACT(DAY FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE)
FROM DUAL;


-- Exercitiul 16
SELECT * FROM USER_TABLES
WHERE TABLE_NAME LIKE UPPER('%_AO');


-- TEMA DE CONTINUAT EXERCITIILE
-- TEMA DE FACUT ULTIMUL EXERCITIU DIN PDF PANA DUMINICA (E1)



-- E1

-- a. https://imgur.com/a/6D3paYd

-- b.


-- 17

-- spool "C:\Users\andre\Desktop\AN2-SEM1\SGBD\Laborator1 spool.txt.txt"
--
-- DROP TABLE MOTOR_CARBURANT;
-- DROP TABLE MOTOR_ELECTRIC;
-- DROP TABLE SHOWROOM_NUMERE_TELEFON;
-- DROP TABLE VEHICUL;
-- DROP TABLE CLIENT_NUMERE_TELEFON;
-- DROP TABLE TRANZACTIE;
-- DROP TABLE SERVICE;
-- DROP TABLE CARBURANT;
-- DROP TABLE MECANIC;
-- DROP TABLE VANZATOR;
-- DROP TABLE VEHICUL_DETINUT_CLIENT;
-- DROP TABLE PLATA;
-- DROP TABLE CAROSERIE;
-- DROP TABLE ANGAJAT_SHOWROOM;
-- DROP TABLE SHOWROOM;
-- DROP TABLE ADRESA;
-- DROP TABLE MOTOR;
-- DROP TABLE CLIENT;
--
-- spool off;



-- 18

-- "SQL> DROP TABLE MOTOR_CARBURANT;
--
-- Table dropped.
--
-- SQL> DROP TABLE MOTOR_ELECTRIC;
--
-- Table dropped.
--
-- SQL> DROP TABLE SHOWROOM_NUMERE_TELEFON;
--
-- Table dropped.
--
-- SQL> DROP TABLE VEHICUL;
--
-- Table dropped.
--
-- SQL> DROP TABLE CLIENT_NUMERE_TELEFON;
--
-- Table dropped.
--
-- SQL> DROP TABLE TRANZACTIE;
--
-- Table dropped.
--
-- SQL> DROP TABLE SERVICE;
--
-- Table dropped.
--
-- SQL> DROP TABLE CARBURANT;
--
-- Table dropped.
--
-- SQL> DROP TABLE MECANIC;
--
-- Table dropped.
--
-- SQL> DROP TABLE VANZATOR;
--
-- Table dropped.
--
-- SQL> DROP TABLE VEHICUL_DETINUT_CLIENT;
--
-- Table dropped.
--
-- SQL> DROP TABLE PLATA;
--
-- Table dropped.
--
-- SQL> DROP TABLE CAROSERIE;
--
-- Table dropped.
--
-- SQL> DROP TABLE ANGAJAT_SHOWROOM;
--
-- Table dropped.
--
-- SQL> DROP TABLE SHOWROOM;
--
-- Table dropped.
--
-- SQL> DROP TABLE ADRESA;
--
-- Table dropped.
--
-- SQL> DROP TABLE MOTOR;
--
-- Table dropped.
--
-- SQL> DROP TABLE CLIENT;
--
-- Table dropped.
--
-- SQL> spool off;"



-- 19

-- 1) "SQL> "
-- 2) REZULTATUL COMENZIILOR INTRODUSE


-- 20

-- Nu se mai arata rezultatul comenziilor:

-- "SQL> DROP TABLE MOTOR_CARBURANT;
-- SQL> DROP TABLE MOTOR_ELECTRIC;
-- SQL> DROP TABLE SHOWROOM_NUMERE_TELEFON;
-- SQL> DROP TABLE VEHICUL;
-- SQL> DROP TABLE CLIENT_NUMERE_TELEFON;
-- SQL> DROP TABLE TRANZACTIE;
-- SQL> DROP TABLE TRANZACTIE;
-- SQL> DROP TABLE SERVICE;
-- SQL> DROP TABLE CARBURANT;
-- SQL> DROP TABLE MECANIC;
-- SQL> DROP TABLE VANZATOR;
-- SQL> DROP TABLE VEHICUL_DETINUT_CLIENT;
-- SQL> DROP TABLE PLATA;
-- SQL> DROP TABLE CAROSERIE;
-- SQL> DROP TABLE ANGAJAT_SHOWROOM;
-- SQL> DROP TABLE SHOWROOM;
-- SQL> DROP TABLE ADRESA;
-- SQL> DROP TABLE MOTOR;
-- SQL> DROP TABLE CLIENT;
-- SQL> spool off"



-- 21
-- SET PAGESIZE 0
-- SELECT * FROM VEHICUL;



-- 22
-- ?


-- 23

-- Folosind tabelul departments generaţi automat script-ul SQL de inserare a înregistrărilor în acest tabel.
SELECT 'INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (' || department_id || ', '''|| department_name || ''', '|| manager_id || ', '|| location_id ||');'
FROM departments;

-- Folosind tabelul MOTOR generaţi automat script-ul SQL de inserare a înregistrărilor în acest tabel.
-- SELECT 'INSERT INTO MOTOR (ID_MOTOR, MARCA, MODEL) VALUES (' || ID_MOTOR || ', '''|| MARCA ||''', '''||MODEL||''');'
-- FROM MOTOR;












