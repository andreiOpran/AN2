SET SERVEROUTPUT ON;

-- Laborator 5 PL/SQL

-- E1.Definiţi un pachet care să permită gestiunea angajaţilor companiei. Pachetul va conţine:
-- a. o procedură care determină adăugarea unui angajat, dându-se informaţii complete despre acesta:
-- - codul angajatului va fi generat automat utilizându-se o secvenţă;
-- - informaţiile personale vor fi date ca parametrii (nume, prenume, telefon, email);
-- - data angajării va fi data curentă;
-- - salariul va fi cel mai mic salariu din departamentul respectiv, pentru jobul respectiv (se vor obţine cu ajutorul unei funcţii stocate în pachet);
-- - nu va avea comision;
-- - codul managerului se va obţine cu ajutorul unei funcţii stocate în pachet care va avea ca parametrii numele şi prenumele managerului);
-- - codul departamentului va fi obţinut cu ajutorul unei funcţii stocate în pachet, dându-se ca parametru numele acestuia;
-- - codul jobului va fi obţinut cu ajutorul unei funcţii stocate în pachet, dându-se ca parametru numele acesteia.
-- Observaţie: Trataţi toate excepţiile. 

-- E1

CREATE SEQUENCE SEQUENCE_EMP_AO
START WITH 1
INCREMENT BY 1
MAXVALUE 99;


CREATE OR REPLACE PACKAGE pachet_employees_ao AS

    FUNCTION get_min_salary(job_name IN VARCHAR2, department_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION get_manager_id(manager_first_name IN VARCHAR2, manager_last_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION get_department_id(department_name IN VARCHAR2) RETURN NUMBER;
    FUNCTION get_job_id(job_name IN VARCHAR2) RETURN VARCHAR2;

    PROCEDURE set_employee(first_name IN VARCHAR2, last_name IN VARCHAR2, phone_number IN VARCHAR2, email IN VARCHAR2, job_name IN VARCHAR2, department_name IN VARCHAR2, manager_first_name IN VARCHAR2, manager_last_name IN VARCHAR2);

    exception_salary EXCEPTION;
    exception_manager EXCEPTION;
    exception_department EXCEPTION;
    exception_job EXCEPTION;

END pachet_employees_ao;
/

CREATE OR REPLACE PACKAGE BODY pachet_employees_ao AS

    FUNCTION get_min_salary(job_name IN VARCHAR2, department_name IN VARCHAR2) RETURN NUMBER IS min_salary NUMBER;
    BEGIN

        SELECT 
            MIN(SALARY) 
        INTO min_salary
        FROM EMP_AO E
        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        WHERE JOB_ID = get_job_id(job_name) AND D.DEPARTMENT_ID = get_department_id(department_name) AND ROWNUM = 1;

        --DBMS_OUTPUT.PUT_LINE('min_salary: ' || TO_CHAR(min_salary));

        IF min_salary IS NULL THEN
            RAISE exception_salary;
        END IF;

        RETURN min_salary;

    END get_min_salary;

    FUNCTION get_manager_id(manager_first_name IN VARCHAR2, manager_last_name IN VARCHAR2) RETURN NUMBER IS manager_id NUMBER;
    BEGIN

        SELECT 
            EMPLOYEE_ID
        INTO manager_id
        FROM EMP_AO
        WHERE FIRST_NAME = manager_first_name AND LAST_NAME = manager_last_name
        AND ROWNUM = 1;

        --DBMS_OUTPUT.PUT_LINE('manager_id: ' || manager_id);

        IF manager_id IS NULL THEN
            RAISE exception_manager;
        END IF;

        RETURN manager_id;

    END get_manager_id;

    FUNCTION get_department_id(department_name IN VARCHAR2) RETURN NUMBER IS department_id NUMBER;
    BEGIN

        SELECT 
            DEPARTMENT_ID
        INTO department_id
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME = department_name AND ROWNUM = 1;

        --DBMS_OUTPUT.PUT_LINE('department_id: ' || department_id);

        IF department_id IS NULL THEN
            RAISE exception_department;
        END IF;

        RETURN department_id;

    END get_department_id;

    FUNCTION get_job_id(job_name IN VARCHAR2) RETURN VARCHAR2 IS job_id VARCHAR2(256);

    BEGIN

        SELECT 
            JOB_ID
        INTO job_id
        FROM JOBS
        WHERE JOB_TITLE = job_name AND ROWNUM = 1;

        --DBMS_OUTPUT.PUT_LINE('job_id: ' || job_id);

        IF job_id IS NULL THEN
            RAISE exception_job;
        END IF;

        RETURN job_id;

    END get_job_id;

    PROCEDURE set_employee(first_name IN VARCHAR2, last_name IN VARCHAR2, phone_number IN VARCHAR2, email IN VARCHAR2, job_name IN VARCHAR2, department_name IN VARCHAR2, manager_first_name IN VARCHAR2, manager_last_name IN VARCHAR2) IS
        v_job_id VARCHAR2(256);
        v_min_salary NUMBER;
        v_manager_id NUMBER;
        v_department_id NUMBER;
    BEGIN

        v_job_id := get_job_id(job_name);
        DBMS_OUTPUT.PUT_LINE('job_id: ' || v_job_id);
        v_min_salary := get_min_salary(job_name, department_name);
        DBMS_OUTPUT.PUT_LINE('min_salary: ' || v_min_salary);
        v_manager_id := get_manager_id(manager_first_name, manager_last_name);
        DBMS_OUTPUT.PUT_LINE('manager_id: ' || v_manager_id);
        v_department_id := get_department_id(department_name);
        DBMS_OUTPUT.PUT_LINE('department_id: ' || v_department_id);

        INSERT INTO EMP_AO(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
        VALUES(SEQUENCE_EMP_AO.NEXTVAL, first_name, last_name, email, phone_number, SYSDATE, v_job_id, v_min_salary, 0, v_manager_id, v_department_id);

    EXCEPTION
        WHEN exception_salary THEN
            RAISE_APPLICATION_ERROR(-20001, 'exceptie salariu');
        WHEN exception_manager THEN
            RAISE_APPLICATION_ERROR(-20002, 'exceptie manager');
        WHEN exception_department THEN
            RAISE_APPLICATION_ERROR(-20003, 'exceptie departament');
        WHEN exception_job THEN
            RAISE_APPLICATION_ERROR(-20004, 'exceptie job');
        WHEN OTHERS THEN
            -- RAISE_APPLICATION_ERROR(-20002, 'eroare necunoscuta');
            DBMS_OUTPUT.PUT_LINE('eroare: ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('mesaj: ' || SQLERRM);


    END set_employee;

END pachet_employees_ao;
/


-- exemplu apelare set_employee

DECLARE 
    
    first_name VARCHAR2(256) := 'Primul';
    last_name VARCHAR2(256) := 'Angajat';
    phone_number VARCHAR2(256) := '0700000000';
    email VARCHAR2(256) := 'primul.angajat@gmail.com';
    job_name VARCHAR2(256) := 'IT_PROG';
    department_name VARCHAR2(256) := 'IT';
    manager_first_name VARCHAR2(256) := 'David';
    manager_last_name VARCHAR2(256) := 'Lee';

    REZULTAT EMP_AO%ROWTYPE;

BEGIN

    pachet_employees_ao.set_employee(first_name, last_name, phone_number, email, job_name, department_name, manager_first_name, manager_last_name);


    SELECT * 
    INTO REZULTAT
    FROM EMP_AO
    WHERE FIRST_NAME = first_name AND LAST_NAME = last_name
    AND ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE('EMPLOYEE_ID: ' || REZULTAT.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('FIRST_NAME: ' || REZULTAT.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('LAST_NAME: ' || REZULTAT.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('EMAIL: ' || REZULTAT.EMAIL);
    DBMS_OUTPUT.PUT_LINE('PHONE_NUMBER: ' || REZULTAT.PHONE_NUMBER);
    DBMS_OUTPUT.PUT_LINE('HIRE_DATE: ' || REZULTAT.HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('JOB_ID: ' || REZULTAT.JOB_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY: ' || REZULTAT.SALARY);
    DBMS_OUTPUT.PUT_LINE('COMMISSION_PCT: ' || REZULTAT.COMMISSION_PCT);
    DBMS_OUTPUT.PUT_LINE('MANAGER_ID: ' || REZULTAT.MANAGER_ID);
    DBMS_OUTPUT.PUT_LINE('DEPARTMENT_ID: ' || REZULTAT.DEPARTMENT_ID);


    -- DBMS_OUTPUT.PUT_LINE('job_id: ' || pachet_employees_ao.get_job_id('Programmer'));
    -- DBMS_OUTPUT.PUT_LINE('manager_id: ' || pachet_employees_ao.get_manager_id('Alexander', 'Hunold'));
    -- DBMS_OUTPUT.PUT_LINE('department_id: ' || pachet_employees_ao.get_department_id('IT'));

    -- DBMS_OUTPUT.PUT_LINE('min_salary: ' || pachet_employees_ao.get_min_salary('IT_PROG', 'IT'));

END;
/





