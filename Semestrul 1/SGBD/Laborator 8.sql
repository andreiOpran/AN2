SET SERVEROUTPUT ON;

-- 12

DECLARE
    TYPE EMPREF IS REF CURSOR;
    V_EMP EMPREF;
    V_NR  INTEGER := &N;

    v_employee_id employees.employee_id%TYPE;
    v_salary employees.salary%TYPE;
    v_commission_pct employees.commission_pct%TYPE;

BEGIN
    OPEN V_EMP FOR 
    'SELECT employee_id, salary, commission_pct ' || 
    'FROM employees WHERE salary > :bind_var'
    USING V_NR;

    LOOP
        FETCH V_EMP INTO v_employee_id, v_salary, v_commission_pct;

        IF(V_SALARY > V_NR) THEN
            IF(V_COMMISSION_PCT IS NULL) THEN
                DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id || ' Salariu: ' || v_salary);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id || ' Salariu: ' || v_salary || ' Comision: ' || v_commission_pct);
            END IF;
        END IF;

        EXIT WHEN V_EMP%NOTFOUND;
    END LOOP;

END;
/



-- Bell, King
DECLARE
  v_nume employees.last_name%TYPE := Initcap('&p_nume');   
 
  FUNCTION f1 RETURN NUMBER IS
    salariu employees.salary%type; 
  BEGIN
    SELECT salary INTO salariu 
    FROM   employees
    WHERE  last_name = v_nume;
    RETURN salariu;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
    WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati cu numele dat');
    WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Alta eroare!');
  END f1;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Salariul este '|| f1);
 
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Eroarea are codul = '||SQLCODE
            || ' si mesajul = ' || SQLERRM);
END;
/


