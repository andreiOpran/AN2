SET SERVEROUTPUT ON;

-- Laborator 3 PL/SQL

-- E1
DECLARE
    V_NR   NUMBER(4);
    V_NUME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    CURSOR C IS
    SELECT
        DEPARTMENT_NAME    NUME,
        COUNT(EMPLOYEE_ID) NR
    FROM DEPARTMENTS D, EMPLOYEES   E
    WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID(+)
    GROUP BY DEPARTMENT_NAME;
BEGIN
    OPEN C;
    
    LOOP
        FETCH C INTO V_NUME, V_NR;
        EXIT WHEN C%NOTFOUND;
        IF V_NR=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| V_NUME|| ' nu lucreaza angajati');
        ELSIF V_NR=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| V_NUME|| ' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| V_NUME|| ' lucreaza '|| V_NR||' angajati');
        END IF;
    END LOOP;

    CLOSE C;
END;
/

-- E2
DECLARE
  TYPE   tab_nume IS TABLE OF departments.department_name%TYPE;
  TYPE   tab_nr IS TABLE OF NUMBER(4);
  t_nr   tab_nr;
  t_nume tab_nume;
  CURSOR c IS
    SELECT department_name nume, COUNT(employee_id) nr  
    FROM   departments d, employees e
    WHERE  d.department_id=e.department_id(+) -- and 1=2
    GROUP BY department_name; 
BEGIN
  OPEN c;
  FETCH c  BULK COLLECT INTO t_nume, t_nr limit 5;
  if t_nume.count=0 then
       DBMS_OUTPUT.PUT_LINE('Nicio linie incarcata');
  else
  DBMS_OUTPUT.PUT_LINE('Primele 5 linii:');
  FOR i IN t_nume.FIRST..t_nume.LAST LOOP
      IF t_nr(i)=0 THEN
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' nu lucreaza angajati');
      ELSIF t_nr(i)=1 THEN
           DBMS_OUTPUT.PUT_LINE('In departamentul '||t_nume(i)||
                           ' lucreaza un angajat');
      ELSE
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' lucreaza '|| t_nr(i)||' angajati');
     END IF;
  END LOOP;
  DBMS_OUTPUT.new_LINE;
  DBMS_OUTPUT.PUT_LINE('Urmatoarele 5 linii:');
  FETCH c  BULK COLLECT INTO t_nume, t_nr limit 5;
 
  FOR i IN t_nume.FIRST..t_nume.LAST LOOP
      IF t_nr(i)=0 THEN
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' nu lucreaza angajati');
      ELSIF t_nr(i)=1 THEN
           DBMS_OUTPUT.PUT_LINE('In departamentul '||t_nume(i)||
                           ' lucreaza un angajat');
      ELSE
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' lucreaza '|| t_nr(i)||' angajati');
     END IF;
  END LOOP;
  DBMS_OUTPUT.new_LINE;
  DBMS_OUTPUT.PUT_LINE('Ultimele linii:');
  FETCH c  BULK COLLECT INTO t_nume, t_nr;
 
  FOR i IN t_nume.FIRST..t_nume.LAST LOOP
      IF t_nr(i)=0 THEN
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' nu lucreaza angajati');
      ELSIF t_nr(i)=1 THEN
           DBMS_OUTPUT.PUT_LINE('In departamentul '||t_nume(i)||
                           ' lucreaza un angajat');
      ELSE
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' lucreaza '|| t_nr(i)||' angajati');
     END IF;
  END LOOP;
  end if;   
  CLOSE c;
END;
/


-- E2 modificat
DECLARE
  TYPE   tab_nume IS TABLE OF departments.department_name%TYPE;
  TYPE   tab_nr IS TABLE OF NUMBER(4);
  t_nr   tab_nr;
  t_nume tab_nume;
  CURSOR c IS
    SELECT department_name nume, COUNT(employee_id) nr  
    FROM   departments d, employees e
    WHERE  d.department_id=e.department_id(+)
    GROUP BY department_name;
BEGIN
    OPEN c;
    LOOP
        FETCH c BULK COLLECT INTO t_nume, t_nr LIMIT 5;
        EXIT WHEN t_nume.COUNT = 0;
       
        FOR i IN t_nume.FIRST..t_nume.LAST LOOP
            IF t_nr(i) = 0 THEN
                DBMS_OUTPUT.PUT_LINE('In departamentul ' || t_nume(i) || ' nu lucreaza angajati');
            ELSIF t_nr(i) = 1 THEN
                DBMS_OUTPUT.PUT_LINE('In departamentul ' || t_nume(i) || ' lucreaza un angajat');
            ELSE
                DBMS_OUTPUT.PUT_LINE('In departamentul ' || t_nume(i) || ' lucreaza ' || t_nr(i) || ' angajati');
            END IF;
        END LOOP;
       
        DBMS_OUTPUT.NEW_LINE;
		DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
   
    CLOSE c;
END;
/

-- E2 modificat varianta profei
DECLARE
  TYPE   tab_nume IS TABLE OF departments.department_name%TYPE;
  TYPE   tab_nr IS TABLE OF NUMBER(4);
  t_nr   tab_nr;
  t_nume tab_nume;
  rows_no number(2);
  CURSOR c IS
    SELECT department_name nume, COUNT(employee_id) nr  
    FROM   departments d, employees e
    WHERE  d.department_id=e.department_id(+)
    GROUP BY department_name; 
BEGIN
  select count(department_id) into rows_no
  from departments;
  OPEN c;
  LOOP
  rows_no := rows_no - 5;
  FETCH c  BULK COLLECT INTO t_nume, t_nr  limit 5;
  exit when c%rowcount = 0 or rows_no < 5 ;
     DBMS_OUTPUT.PUT_LINE('Linii ramase de procesat  ' || rows_no);
    FOR i IN t_nume.FIRST..t_nume.LAST LOOP
      IF t_nr(i)=0 THEN
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' nu lucreaza angajati');
      ELSIF t_nr(i)=1 THEN
           DBMS_OUTPUT.PUT_LINE('In departamentul '||t_nume(i)||
                           ' lucreaza un angajat');
      ELSE
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' lucreaza '|| t_nr(i)||' angajati');
     END IF;
  END LOOP;
  end loop;
  if rows_no != 0 then
    FETCH c  BULK COLLECT INTO t_nume, t_nr;
    DBMS_OUTPUT.PUT_LINE('Ultimele  ' || rows_no);
    FOR i IN t_nume.FIRST..t_nume.LAST LOOP
      IF t_nr(i)=0 THEN
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' nu lucreaza angajati');
      ELSIF t_nr(i)=1 THEN
           DBMS_OUTPUT.PUT_LINE('In departamentul '||t_nume(i)||
                           ' lucreaza un angajat');
      ELSE
         DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||
                           ' lucreaza '|| t_nr(i)||' angajati');
     END IF;
    END LOOP;
  end if;
  CLOSE c;
END;
/


-- E5
DECLARE
	V_COD  EMPLOYEES.EMPLOYEE_ID%TYPE;
	V_NUME EMPLOYEES.LAST_NAME%TYPE;
	V_NR   NUMBER(4);

	V_COD_AUX  EMPLOYEES.EMPLOYEE_ID%TYPE;
	V_NUME_AUX EMPLOYEES.LAST_NAME%TYPE;
	V_NR_AUX   NUMBER(4);

	V_CONT NUMBER(4):=0;
	CURSOR C IS
	SELECT
		SEF.EMPLOYEE_ID    COD,
		MAX(SEF.LAST_NAME) NUME,
		COUNT(*)           NR
	FROM EMPLOYEES SEF, EMPLOYEES ANG
	WHERE ANG.MANAGER_ID = SEF.EMPLOYEE_ID
	GROUP BY SEF.EMPLOYEE_ID
	ORDER BY NR DESC;
BEGIN
	OPEN C;
	
	LOOP
		FETCH C INTO V_COD, V_NUME, V_NR;
		EXIT WHEN V_CONT >= 3 OR C%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Managerul '|| V_COD || ' avand numele ' || V_NUME || ' conduce ' || V_NR||' angajati');
		V_CONT := V_CONT + 1;
		LOOP 
			FETCH C INTO V_COD_AUX, V_NUME_AUX, V_NR_AUX;
			EXIT WHEN V_NR_AUX < V_NR OR C%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE('Managerul '|| V_COD_AUX || ' avand numele ' || V_NUME_AUX || ' conduce ' || V_NR_AUX||' angajati');
		END LOOP;
	END LOOP;

	CLOSE C;
END;
/