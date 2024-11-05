SET SERVEROUTPUT ON;

--Ex. 4 (modificat)
DECLARE
  TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  t    tablou_indexat;
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
  t(19) := 9;
  DBMS_OUTPUT.PUT_LINE('Ultimul element are indicele ' || t.last ||
         ' si valoarea ' || nvl(t(t.last),0));
  DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente: ');
--
  FOR i IN t.FIRST..t.LAST LOOP
    IF t.EXISTS(i) THEN 
      DBMS_OUTPUT.PUT(' indicele: ' || i || ' si valoarea ' || nvl(t(i), 0) || ', '); 
    end if;
  END LOOP;
  t.delete;
  DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente.');
END;
/



-- DECLARARE SI POPULARE TABEL CU %ROWTYPE INCORECT
DECLARE
  TYPE tablou_imbricat IS TABLE OF employees%ROWTYPE;
  t tablou_imbricat := tablou_imbricat();
BEGIN
    t.EXTEND(30);
    SELECT *
    BULK COLLECT INTO t
    FROM employees;
    
    FOR CONT IN t.FIRST..t.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(t(cont));
    END LOOP;
END;
/


-- VARIANTA CORECTA
DECLARE
    TYPE tablou_imbricat IS TABLE OF employees%ROWTYPE;
    t tablou_imbricat := tablou_imbricat();
BEGIN
    SELECT *
    BULK COLLECT INTO t
    FROM employees
    WHERE rownum <= 10;
   
    FOR i IN t.FIRST..t.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(t(i).first_name || ' ' || t(i).last_name);
    END LOOP;
END;
/




--Ex. 4 (modificat cu vectori) (incorect)                                                                                                  
DECLARE
  TYPE VECTOR IS VARRAY(20) OF NUMBER(6);
  V    VECTOR := VECTOR();
BEGIN
-- punctul a

--  FOR i IN 1..10 LOOP
--    t(i):=i;
--  END LOOP;
--  DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
--  FOR i IN t.FIRST..t.LAST LOOP
--      DBMS_OUTPUT.PUT(t(i) || ' '); 
--  END LOOP;
--  DBMS_OUTPUT.NEW_LINE;

FOR I IN 1..10 LOOP
    V(I) := I;
END LOOP;
DBMS_OUTPUT.PUT('Tabloul are ' || V.COUNT ||' elemente: ');

FOR I IN 1..10 LOOP
    DBMS_OUTPUT.PUT(V(I) || ' ');
END LOOP;


-- punctul b

--  FOR i IN 1..10 LOOP
--    IF i mod 2 = 1 THEN t(i):=null; 
--    END IF;
--  END LOOP;
--  DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
-- 
--  FOR i IN t.FIRST..t.LAST LOOP
--      DBMS_OUTPUT.PUT(nvl(t(i), 0) || ' '); 
--  END LOOP;
--DBMS_OUTPUT.NEW_LINE;
 
-- punctul c

--  t.DELETE(t.first);
--  t.DELETE(5,7);
--  t.DELETE(t.last);
--  DBMS_OUTPUT.PUT_LINE('Primul element are indicele ' || t.first ||
--         ' si valoarea ' || nvl(t(t.first),0));
--  DBMS_OUTPUT.PUT_LINE('Ultimul element are indicele ' || t.last ||
--         ' si valoarea ' || nvl(t(t.last),0));
--  DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
--  FOR i IN t.FIRST..t.LAST LOOP
--     IF t.EXISTS(i) THEN 
--        DBMS_OUTPUT.PUT(nvl(t(i), 0)|| ' '); 
--     END IF;
--  END LOOP;
--  DBMS_OUTPUT.NEW_LINE;
 
-- punctul d

--  t(19) := 9;
--  DBMS_OUTPUT.PUT_LINE('Ultimul element are indicele ' || t.last ||
--         ' si valoarea ' || nvl(t(t.last),0));
--  DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente: ');
----
--  FOR i IN t.FIRST..t.LAST LOOP
--    IF t.EXISTS(i) THEN 
--      DBMS_OUTPUT.PUT(' indicele: ' || i || ' si valoarea ' || nvl(t(i), 0) || ', '); 
--    end if;
--  END LOOP;
--  t.delete;
--  DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente.');
END;
/





--10
CREATE TABLE emp_test_prof AS 
      SELECT employee_id, last_name FROM employees
      WHERE ROWNUM <= 2;
CREATE OR REPLACE TYPE tip_telefon_prof IS TABLE OF VARCHAR(12);
/
select * from emp_test_prof
 
ALTER TABLE emp_test_prof
ADD (telefon tip_telefon_prof) 
NESTED TABLE telefon STORE AS tabel_telefon_prof;
 
INSERT INTO emp_test_prof 
VALUES (500, 'XYZ',tip_telefon_prof('074XXX', '0213XXX', '037XXX'));
 
update  emp_test_prof
SET telefon = tip_telefon_prof('073XXX', '0214XXX')
WHERE employee_id=100;
 
SELECT  a.employee_id, b.*
FROM    emp_test_prof a, TABLE (a.telefon) b;
 
SELECT  a.employee_id, b.*
FROM    emp_test_prof a, TABLE (a.telefon)(+) b;
 
 
select a.employee_id, b.*
from  emp_test_prof a, table(a.telefon) b
union all
select a.employee_id, null
from  emp_test_prof a
where cardinality(a.telefon) is null;
has context menu




-- TEMA 1 -> PENTRU SAPT VIITOARE E1, E2 (A, B) 
-- TEMA 2 -> PENTRU CELALATA SAPTAMANA E2 (C, D, E), E3


































