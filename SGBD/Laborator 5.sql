SET SERVEROUTPUT ON;

-- E2
DECLARE
    TYPE EMP_RECORD IS RECORD (
     ID_ANG EMPLOYEES.EMPLOYEE_ID%TYPE,
     JOB_ID EMPLOYEES.JOB_ID%TYPE,
     SALARY EMPLOYEES.SALARY%TYPE
    );
    
    REC_ANG EMP_RECORD;
BEGIN

    REC_ANG.ID_ANG := 100;
    REC_ANG.JOB_ID := 12;
    REC_ANG.SALARY := 500;
    
    DBMS_OUTPUT.PUT_LINE('ID-ul angajatului este: ' || rec_ang.id_ang 
    || ' si are salariul: ' || rec_ang.salary || ' si job-ul: ' || rec_ang.job_id);

END;
/   


-- EXEMPLU RECORD CU ROWTYPE
DECLARE
    TYPE emp_record IS RECORD (
        var_emp employees%ROWTYPE,
        bonus_salariu employees.salary%type
     );
    v_ang emp_record;
    var_emp1 employees%ROWTYPE;
BEGIN
 
     v_ang.var_emp.employee_id:=700;
     v_ang.bonus_salariu := 1000;
     DBMS_OUTPUT.PUT_LINE ('Angajatul cu codul ' ||v_ang.var_emp.employee_id || ' are bonusul salarial ' || v_ang.bonus_salariu);

END;
/


-- RECORD IMBRICAT
DECLARE
    TYPE emp1_record is RECORD (
        zile_concediu number(2),
        vechime number(2)
    );
 
    TYPE emp_record IS RECORD (
        var_emp employees%ROWTYPE,
        bonus_salariu employees.salary%type,
        var_detalii emp1_record
     );
    v_ang emp_record;
    var_emp1 employees%ROWTYPE;
BEGIN
 
     v_ang.var_emp.employee_id:=700;
     v_ang.bonus_salariu := 1000;
     v_ang.var_detalii.zile_concediu := 25;
     v_ang.var_detalii.vechime := 5;
     DBMS_OUTPUT.PUT_LINE ('Angajatul cu codul ' ||v_ang.var_emp.employee_id || ' are bonusul salarial ' 
     || v_ang.bonus_salariu || ' are ' || v_ang.var_detalii.zile_concediu  || ' zile de concediu '
     || ' si ' || v_ang.var_detalii.vechime || ' ani vechime'); 
END;
/



-- E2 B) SI C)
DECLARE
    TYPE EMP_RECORD IS RECORD (
     COD EMPLOYEES.EMPLOYEE_ID%TYPE,
     JOB EMPLOYEES.JOB_ID%TYPE,
     SALARIU EMPLOYEES.SALARY%TYPE
    );
    
    V_ANG EMP_RECORD;
BEGIN

    DELETE FROM EMP_LBC
    WHERE EMPLOYEE_ID = 100
    RETURNING EMPLOYEE_ID, JOB_ID, SALARY INTO V_ANG;
    DBMS_OUTPUT.PUT_LINE('ANGAJATUL CU CODUL ' || V_ANG.COD);

    ROLLBACK;
END;
/   

-- DIN CHAT
DECLARE
    type emp_record is record (
        cod employees.employee_id%type,
        job employees.job_id%type,
        salariu employees.salary%type
    );
    v_ang emp_record;
BEGIN
    DELETE FROM emp_lbc
    WHERE employee_id=0
    RETURNING employee_id, job_id, salary INTO v_ang;
    DBMS_OUTPUT.PUT_LINE ('Angajatul cu codul '|| v_ang.cod || 
     ' si jobul ' || v_ang.job || ' are salariul ' || v_ang.salariu);
END;
/

-- EXERCITIUL PRECEDENT CU EXCEPTIE
DECLARE
    type emp_record is record (
        cod employees.employee_id%type,
        job employees.job_id%type,
        salariu employees.salary%type
    );
    v_ang emp_record;
    
    NICIUN_ANGAJAT EXCEPTION;
BEGIN
    DELETE FROM emp_lbc
    -- WHERE EMPLOYEE_ID = 0 -- NICIUN ANGAJAT
    -- WHERE SALARY = 4800 -- TOO MANY ROWS
    WHERE SALARY = 'ABC'
    RETURNING employee_id, job_id, salary INTO v_ang;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE NICIUN_ANGAJAT;
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Angajatul cu codul ' || v_ang.cod || 
     ' si jobul ' || v_ang.job || ' are salariul ' || v_ang.salariu);
    END IF;
    
EXCEPTION
    WHEN NICIUN_ANGAJAT THEN
        DBMS_OUTPUT.PUT_LINE('NICIUN ANGAJAT CU ID-UL DAT');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('EXISTA MAI MULTI ANGAJATI CU ACEST SALARIU');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OTHER ERROR: ' || SQLERRM || ' ' || SQLCODE);
END;
/


ROLLBACK;


-- E3
DECLARE
v_ang1 employees%ROWTYPE;
v_ang2 employees%ROWTYPE;
BEGIN
-- sterg angajat 100 si mentin in variabila linia stearsa
     DELETE FROM emp_lbc
     WHERE employee_id = 100
     RETURNING employee_id, first_name, last_name, email, phone_number,
     hire_date, job_id, salary, commission_pct, manager_id,
     department_id
     INTO v_ang1;
-- inserez in tabel linia stearsa
     INSERT INTO emp_lbc
     VALUES v_ang1;
-- sterg angajat 101 
     DELETE FROM emp_lbc
     WHERE employee_id = 101
          RETURNING employee_id, first_name, last_name, email, phone_number,
     hire_date, job_id, salary, commission_pct, manager_id,
     department_id
     INTO v_ang2;
     INSERT INTO emp_lbc
     VALUES v_ang2;
end;


-- E4
DECLARE
     TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
     t tablou_indexat;
BEGIN
-- punctul a
     FOR i IN 1..10 LOOP
        t(i):=i;
     END LOOP;
     DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
     FOR i IN t.FIRST..t.LAST LOOP
        DBMS_OUTPUT.PUT(t(i) || ' '); 
     END LOOP;
     DBMS_OUTPUT.NEW_LINE;
-- punctul b
     FOR i IN 1..10 LOOP
     IF i mod 2 = 1 THEN t(i):=null;
     END IF;
     END LOOP;
     DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
     FOR i IN t.FIRST..t.LAST LOOP
     DBMS_OUTPUT.PUT(nvl(t(i), 0) || ' '); 
     END LOOP;
     DBMS_OUTPUT.NEW_LINE;
-- punctul c
     t.DELETE(t.first);
     t.DELETE(5,7);
     t.DELETE(t.last);
     DBMS_OUTPUT.PUT_LINE('Primul element are indicele ' || t.first ||
     ' si valoarea ' || nvl(t(t.first),0));
    DBMS_OUTPUT.PUT_LINE('Ultimul element are indicele ' || t.last ||
     ' si valoarea ' || nvl(t(t.last),0));
     DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
     FOR i IN t.FIRST..t.LAST LOOP
     IF t.EXISTS(i) THEN 
     DBMS_OUTPUT.PUT(nvl(t(i), 0)|| ' '); 
     END IF;
END LOOP;
DBMS_OUTPUT.NEW_LINE;
-- punctul d
     t.delete;
     DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente.');
END;


-- E5
DECLARE 
    TYPE tablou_indexat IS 
    TABLE OF emp_lbc%ROWTYPE 
    INDEX BY BINARY_INTEGER; 
    t tablou_indexat; 
BEGIN 
    
    -- stergere din tabel si salvare in tablou 
    DELETE FROM emp_lbc 
    WHERE ROWNUM<= 2 
    returning employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
    bulk collect into t;
    
    --afisare elemente tablou 
    dbms_output.put_line (t(1).employee_id ||' ' || t(1).last_name); 
    (t(2).employee_id t(2).last_name); 
    
    --inserare cele linii in tabel 
    insert emp_lbc values t(1); 
    insert emp_lbc values t(2); 
end; 
/







