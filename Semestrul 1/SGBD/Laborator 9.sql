SET SERVEROUTPUT ON;

-- 6 
DECLARE
nume employees.last_name%TYPE;
PROCEDURE p6 (rezultat OUT employees.last_name%TYPE,
              comision IN  employees.commission_pct%TYPE:=NULL,
              cod      IN  employees.employee_id%TYPE:=NULL) 
IS
BEGIN
IF (comision IS NOT NULL) THEN
    SELECT last_name 
    INTO rezultat
    FROM employees
    WHERE commission_pct= comision;
    DBMS_OUTPUT.PUT_LINE('numele salariatului care are comisionul ' ||comision||' este '||rezultat);
ELSE 
    SELECT last_name 
    INTO rezultat
    FROM employees
    WHERE employee_id =cod;
    DBMS_OUTPUT.PUT_LINE('numele salariatului avand codul ' ||cod||' este '||rezultat);
END IF;

EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati cu comisionul ' || comision);
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu s-au gasit angajati cu datele specificate');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM || ' ' || SQLCODE);
END p6;
 
BEGIN
  --p6(nume,0.4);
  --p6(nume,cod=>1232);
  p6(nume,0.2);
END;
/



-- SELECT * FROM USER_USERS;
-- SQLERRM
-- INFO_LBC

SELECT * FROM INFO_LBC;



-- E2

-- 2
CREATE OR REPLACE FUNCTION F2_*** (
    V_NUME EMPLOYEES.LAST_NAME%TYPE DEFAULT 'Bell'
) RETURN NUMBER IS
    SALARIU EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT
        SALARY INTO SALARIU
    FROM
        EMPLOYEES
    WHERE
        LAST_NAME = V_NUME;
    RETURN SALARIU;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END F2_***;
/

-- metode de apelare
-- 1. bloc plsql
BEGIN
    DBMS_OUTPUT.PUT_LINE('Salariul este '|| F2_***);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Salariul este '|| F2_***('King'));
END;
/

-- 2. SQL
SELECT
    F2_***
FROM
    DUAL;

SELECT
    F2_***('King')
FROM
    DUAL;

-- 3. SQL*PLUS CU VARIABILA HOST
VARIABLE nr NUMBER
EXECUTE :nr := f2_***('Bell');
PRINT nr


-- 4
-- varianta 1
CREATE OR REPLACE PROCEDURE p4_***
 (v_nume employees.last_name%TYPE)
 IS
 salariu employees.salary%TYPE;
 BEGIN
 SELECT salary INTO salariu
 FROM employees
 WHERE last_name = v_nume;
 DBMS_OUTPUT.PUT_LINE('Salariul este '|| salariu);

 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 RAISE_APPLICATION_ERROR(-20000,
 'Nu exista angajati cu numele dat');
 WHEN TOO_MANY_ROWS THEN
 RAISE_APPLICATION_ERROR(-20001,
 'Exista mai multi angajati cu numele dat');
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
 END p4_***;
/
-- metode apelare
-- 1. Bloc PLSQL
BEGIN
 p4_***('Bell');
END;
/
-- 2. SQL*PLUS
EXECUTE p4_***('Bell');
EXECUTE p4_***('King');
EXECUTE p4_***('Kimball');


-- varianta 1
CREATE OR REPLACE PROCEDURE P4_*** (
    V_NUME EMPLOYEES.LAST_NAME%TYPE
) IS
    SALARIU EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT
        SALARY INTO SALARIU
    FROM
        EMPLOYEES
    WHERE
        LAST_NAME = V_NUME;
    DBMS_OUTPUT.PUT_LINE('Salariul este '|| SALARIU);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END P4_***;
/

-- metode apelare
-- 1. Bloc PLSQL
BEGIN
    P4_***('Bell');
END;
/

-- 2. SQL*PLUS
EXECUTE p4_***('Bell');

EXECUTE p4_***('King');

EXECUTE p4_***('Kimball');

-- varianta 2
CREATE OR REPLACE PROCEDURE P4_***(
    V_NUME IN EMPLOYEES.LAST_NAME%TYPE,
    SALARIU OUT EMPLOYEES.SALARY%TYPE
) IS
BEGIN
    SELECT
        SALARY INTO SALARIU
    FROM
        EMPLOYEES
    WHERE
        LAST_NAME = V_NUME;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END P4_***;
/

-- metode apelare
-- 1. Bloc PLSQL
DECLARE
    V_SALARIU EMPLOYEES.SALARY%TYPE;
BEGIN
    P4_***('Bell', V_SALARIU);
    DBMS_OUTPUT.PUT_LINE('Salariul este '|| V_SALARIU);
END;
/

-- 2. SQL*PLUS
VARIABLE v_sal NUMBER

EXECUTE p4_*** ('Bell', :v_sal)

PRINT v_sal



--E2

-- Modificați funcția definită la exercițiul 2, respectiv procedura definită la exercițiul 4 astfel încât
-- să determine inserarea în tabelul info_*** a informațiile corespunzătoare fiecărui caz
-- determinat de valoarea dată pentru parametru:
-- - există un singur angajat cu numele specificat;
-- - există mai mulți angajați cu numele specificat;
-- - nu există angajați cu numele specificat. 


CREATE OR REPLACE FUNCTION E2_functie_ex2 (
    V_NUME EMPLOYEES.LAST_NAME%TYPE DEFAULT 'Bell'
) RETURN NUMBER IS
    SALARIU EMPLOYEES.SALARY%TYPE;
    V_USER USER_USERS.USERNAME%TYPE;
    CONT NUMBER(6) := 0;
    EROARE VARCHAR2(100);
BEGIN

    SELECT
        SALARY INTO SALARIU
    FROM EMPLOYEES
    WHERE LAST_NAME = V_NUME;

    SELECT
        USERNAME INTO V_USER
    FROM USER_USERS;
    
    V_USER := V_USER || '_AO';

    INSERT INTO INFO_LBC (UTILIZATOR, DATA, COMANDA, NR_LINII, EROARE)
    VALUES (V_USER, SYSDATE, 'E2_functie_ex2', 1, NULL);

    COMMIT;

    RETURN SALARIU;

EXCEPTION
    WHEN NO_DATA_FOUND THEN

        SELECT
            USERNAME INTO V_USER
        FROM USER_USERS;

        V_USER := V_USER || '_AO';

        INSERT INTO INFO_LBC (UTILIZATOR, DATA, COMANDA, NR_LINII, EROARE)
        VALUES (V_USER, SYSDATE, 'E2_functie_ex2', 0, 'Nu exista angajati cu numele dat');

        COMMIT;

        RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat');
        
    WHEN TOO_MANY_ROWS THEN
            
        SELECT
            COUNT(*) INTO CONT
        FROM EMPLOYEES
        WHERE LAST_NAME = V_NUME;

        DBMS_OUTPUT.PUT_LINE('CONT: ' ||  CONT);


        SELECT
            USERNAME INTO V_USER
        FROM USER_USERS;

        V_USER := V_USER || '_AO';

        INSERT INTO INFO_LBC (UTILIZATOR, DATA, COMANDA, NR_LINII, EROARE)
        VALUES (V_USER, SYSDATE, 'E2_functie_ex2', CONT, 'Exista mai multi angajati cu numele dat');

        COMMIT;

        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat');
        
    WHEN OTHERS THEN
        
        SELECT
            USERNAME INTO V_USER
        FROM USER_USERS;

        V_USER := V_USER || '_AO';
        
        EROARE := SQLERRM;

        INSERT INTO INFO_LBC (UTILIZATOR, DATA, COMANDA, NR_LINII, EROARE)
        VALUES (V_USER, SYSDATE, 'E2_functie_ex2', 0, EROARE);
        
        COMMIT;

        RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);

END E2_functie_ex2;
/


-- metode de apelare
-- 1. bloc plsql
BEGIN
    DBMS_OUTPUT.PUT_LINE('Salariul este '|| E2_functie_ex2('Bell'));
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Salariul este '|| E2_functie_ex2('INEXISTENT'));
END;
/

select * from user_users;
SELECT * FROM INFO_LBC;

