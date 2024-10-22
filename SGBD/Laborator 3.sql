-- TEMA 1
-- In Oracle SQL Developer rulezi script-urile de SQLPlus cu F5


-- 4
DECLARE v_dep departments.department_name%TYPE;
BEGIN
    SELECT
        department_name INTO v_dep
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM employees
    GROUP BY department_id);
    DBMS_OUTPUT.PUT_LINE('Departamentul '|| v_dep);
END;



-- Varianta 1
SET SERVEROUTPUT ON;

DECLARE
    v_dep departments.department_name%TYPE;
    v_num_employees NUMBER;
BEGIN
    SELECT department_name, COUNT(*) AS num_employees
    INTO v_dep, v_num_employees
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    DBMS_OUTPUT.PUT_LINE('Departamentul ' || v_dep || ' = ' || v_num_employees || ' angajati.');
END;



-- Varianta 2
DECLARE
    v_dep departments.department_name%TYPE;
    nr_ang number;
BEGIN
    SELECT department_name
    INTO v_dep
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = ( SELECT MAX(COUNT(*))
                        FROM employees
                        GROUP BY department_id);

    SELECT COUNT(*)
    INTO nr_ang
    FROM employees e, departments d
    WHERE e.department_id=d.department_id AND d.department_name=v_dep;

    DBMS_OUTPUT.PUT_LINE('Departamentul '|| v_dep);
    DBMS_OUTPUT.PUT_LINE('Numarul de angajati '|| nr_ang);
END;



-- 5
VARIABLE rezultat VARCHAR2(35)
BEGIN
SELECT department_name
INTO :rezultat
FROM employees e, departments d
WHERE e.department_id=d.department_id
GROUP BY department_name
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM employees
GROUP BY department_id);
DBMS_OUTPUT.PUT_LINE('Departamentul '|| :rezultat);
END;
/
PRINT rezultat



-- 7
SET VERIFY OFF 
DECLARE 
    v_cod employees.employee_id%TYPE:=&p_cod; 
    v_bonus NUMBER(8); 
    v_salariu_anual NUMBER(8); 
BEGIN 
    SELECT 
        salary*12 
    INTO v_salariu_anual 
    FROM employees 
    WHERE employee_id = v_cod; 
    
    IF v_salariu_anual>=200001 
        THEN v_bonus:=20000; 
    ELSIF v_salariu_anual BETWEEN 100001 AND 200000 
        THEN v_bonus:=10000; 
    ELSE v_bonus:=5000; 
    END IF; 
    
    DBMS_OUTPUT.PUT_LINE('Bonusul este ' || v_bonus); 

    EXCEPTION 
    when 
    NO_DATA_FOUND 
    then dbms_output.put_line('Nu a fost gasit niciun angajat cu id-ul introdus!');
END; 
/ 

SET VERIFY ON


--8















































