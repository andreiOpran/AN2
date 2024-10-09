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
WHERE TABLE_NAME LIKE UPPER('%_AO')


-- TEMA DE CONTINUAT EXERCITIILE
-- TEMA DE FACUT ULTIMUL EXERCITIU DIN PDF PANA DUMINICA (E1)





















