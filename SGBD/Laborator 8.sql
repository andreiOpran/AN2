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