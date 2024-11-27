SET SERVEROUTPUT ON;



-------------------------------------- Exercitiul 1 pagina 2 --------------------------------------


-- 1. Obțineți pentru fiecare departament numele acestuia și numărul de angajați, într-una din
-- următoarele forme:
-- “ În departamentul <nume departament> nu lucrează angajati”.
-- “ În departamentul <nume departament> lucrează un angajat”.
-- “ În departamentul <nume departament> lucrează <numar> angajati”.
-- Rezolvați problema folosind un cursor explicit.
DECLARE
	V_NR NUMBER(4);
	V_NUME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
	CURSOR C IS
	SELECT
		DEPARTMENT_NAME AS NUME,
		COUNT(EMPLOYEE_ID) AS NR
	FROM DEPARTMENTS D, EMPLOYEES   E
	WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID(+)
	GROUP BY DEPARTMENT_NAME;

	V_CONT NUMBER(6) := 0;

BEGIN
	OPEN C;
	LOOP
		FETCH C INTO V_NUME, V_NR;
		EXIT WHEN C%NOTFOUND;

		V_CONT := V_CONT + 1;

		IF V_NR=0 THEN
			DBMS_OUTPUT.PUT_LINE(V_CONT || ': ' || 'In departamentul '|| V_NUME|| ' nu lucreaza angajati');
		ELSIF V_NR=1 THEN
			DBMS_OUTPUT.PUT_LINE(V_CONT || ': ' || 'In departamentul '|| V_NUME|| ' lucreaza un angajat');
		ELSE
			DBMS_OUTPUT.PUT_LINE(V_CONT || ': ' || 'In departamentul '|| V_NUME|| ' lucreaza '|| V_NR||' angajati');
		END IF;
	END LOOP;

	CLOSE C;
END;
/



-------------------------------------- Exercitiul 2 pagina 2 --------------------------------------


-- Rezolvați exercițiul 1 menținând informațiile din cursor în colecții. Comentați. 
-- Procesați toate liniile din cursor, încărcând la fiecare pas câte 5 linii.
-- Temă: 
-- Rezolvați problema folosind cursorul și o singură colecție.
-- Rezolvați problema folosind doar colecții. 


-- Rezolvați exercițiul 1 menținând informațiile din cursor în colecții. Comentați. 
-- Procesați toate liniile din cursor, încărcând la fiecare pas câte 5 linii.
DECLARE

	TYPE TIP_TABEL_DEPARTMENT_NAME IS TABLE OF DEPARTMENTS.DEPARTMENT_NAME%TYPE INDEX BY PLS_INTEGER;
	TYPE TIP_TABEL_NR IS TABLE OF NUMBER(4) INDEX BY PLS_INTEGER;

	TABEL_DEPARTMENT_NAME TIP_TABEL_DEPARTMENT_NAME;
	TABEL_NR TIP_TABEL_NR;

	CURSOR C IS
	SELECT
		DEPARTMENT_NAME AS NUME,
		COUNT(EMPLOYEE_ID) AS NR
	FROM DEPARTMENTS D, EMPLOYEES   E
	WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID(+)
	GROUP BY DEPARTMENT_NAME;

	V_CONT NUMBER(6) := 0;
	
BEGIN
	
	OPEN C;

	LOOP

		

		FETCH C BULK COLLECT INTO TABEL_DEPARTMENT_NAME, TABEL_NR LIMIT 5;
		EXIT WHEN TABEL_DEPARTMENT_NAME.COUNT=0; -- CA SA AFISEZE SI 1-4 LINII CARE SUNT DUPA UN MULTIPLU DE 5

		FOR I IN 1..TABEL_DEPARTMENT_NAME.COUNT LOOP

			V_CONT := V_CONT + 1;

			IF TABEL_NR(I) = 0 THEN
				DBMS_OUTPUT.PUT_LINE(V_CONT || ': ' || 'In departamentul '|| TABEL_DEPARTMENT_NAME(I)|| ' nu lucreaza angajati');
			ELSIF TABEL_NR(I) = 1 THEN
				DBMS_OUTPUT.PUT_LINE(V_CONT || ': ' || 'In departamentul '|| TABEL_DEPARTMENT_NAME(I)|| ' lucreaza un angajat');
			ELSE
				DBMS_OUTPUT.PUT_LINE(V_CONT || ': ' || 'In departamentul '|| TABEL_DEPARTMENT_NAME(I) || ' lucreaza ' || TABEL_NR(I) || ' angajati');
			END IF;
		END LOOP;

	END LOOP;

	CLOSE C;
END;
/


--  Rezolvați problema folosind cursorul și o singură colecție.
DECLARE

	TYPE PAIR IS RECORD(
		
		V_NUME DEPARTMENTS.DEPARTMENT_NAME%TYPE,
		V_NR NUMBER(4)
	
	);

	TYPE TIP_TABEL_PAIR IS TABLE OF PAIR INDEX BY PLS_INTEGER;
	TABEL_PAIR TIP_TABEL_PAIR;

	V_NR NUMBER(4);

	CURSOR C IS
	SELECT
		DEPARTMENT_NAME AS NUME,
		COUNT(EMPLOYEE_ID) AS NR
	FROM DEPARTMENTS D, EMPLOYEES   E
	WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID(+)
	GROUP BY DEPARTMENT_NAME;
BEGIN

	OPEN C;
	
	LOOP

		FETCH C BULK COLLECT INTO TABEL_PAIR;
		EXIT WHEN TABEL_PAIR.COUNT = 0;

		FOR I IN 1..TABEL_PAIR.COUNT LOOP
			IF TABEL_PAIR(I).V_NR = 0 THEN
				DBMS_OUTPUT.PUT_LINE(I || ': ' || 'In departamentul '|| TABEL_PAIR(I).V_NUME  || ' nu lucreaza angajati');
			ELSIF TABEL_PAIR(I).V_NR = 1 THEN
				DBMS_OUTPUT.PUT_LINE(I || ': ' || 'In departamentul '|| TABEL_PAIR(I).V_NUME || ' lucreaza un angajat');
			ELSE
				DBMS_OUTPUT.PUT_LINE(I || ': ' || 'In departamentul '|| TABEL_PAIR(I).V_NUME || ' lucreaza ' || TABEL_PAIR(I).V_NR || ' angajati');
			END IF;
		END LOOP;
	
	END LOOP;

	CLOSE C;
END;
/


--  Rezolvați problema folosind doar colecții. 
DECLARE
	TYPE TIP_TABEL_DEPARTMENT_NAME IS TABLE OF DEPARTMENTS.DEPARTMENT_NAME%TYPE INDEX BY PLS_INTEGER;
	TYPE TIP_TABEL_NR IS TABLE OF NUMBER(4) INDEX BY PLS_INTEGER;

	TABEL_DEPARTMENT_NAME TIP_TABEL_DEPARTMENT_NAME;
	TABEL_NR TIP_TABEL_NR;

BEGIN
	
	SELECT
		DEPARTMENT_NAME AS NUME,
		COUNT(EMPLOYEE_ID) AS NR
	BULK COLLECT INTO TABEL_DEPARTMENT_NAME, TABEL_NR
	FROM DEPARTMENTS D, EMPLOYEES   E
	WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID(+)
	GROUP BY DEPARTMENT_NAME;

	FOR I IN 1..TABEL_DEPARTMENT_NAME.COUNT LOOP
		IF TABEL_NR(I) = 0 THEN
			DBMS_OUTPUT.PUT_LINE(I || ': ' || 'In departamentul '|| TABEL_DEPARTMENT_NAME(I)|| ' nu lucreaza angajati');
		ELSIF TABEL_NR(I) = 1 THEN
			DBMS_OUTPUT.PUT_LINE(I || ': ' || 'In departamentul '|| TABEL_DEPARTMENT_NAME(I)|| ' lucreaza un angajat');
		ELSE
			DBMS_OUTPUT.PUT_LINE(I || ': ' || 'In departamentul '|| TABEL_DEPARTMENT_NAME(I) || ' lucreaza ' || TABEL_NR(I) || ' angajati');
		END IF;
	END LOOP;

END;
/





--------------------------------------------- E1 pagina 10 ---------------------------------------------


-- Pentru fiecare job (titlu – care va fi afișat o singură dată) obțineți lista angajaților (nume și
-- salariu) care lucrează în prezent pe jobul respectiv. Tratați cazul în care nu există angajați care
-- să lucreze în prezent pe un anumit job. Rezolvați problema folosind:
-- a. cursoare clasice
-- b. ciclu cursoare
-- c. ciclu cursoare cu subcereri
-- d. expresii cursor



-- a. cursoare clasice
DECLARE

	titluJob JOBS.JOB_TITLE%TYPE;

	auxNume EMPLOYEES.LAST_NAME%TYPE;
	auxSalariu EMPLOYEES.SALARY%TYPE;

	v_cont NUMBER(6) := 0;

	CURSOR C1 IS
	SELECT 
		DISTINCT JOB_TITLE
	FROM JOBS;

	CURSOR C2(titluJobParametru JOBS.JOB_TITLE%TYPE) IS
	SELECT
		E.LAST_NAME AS NUME,
		E.SALARY AS SALARIU
	FROM EMPLOYEES E, JOBS J
	WHERE E.JOB_ID = J.JOB_ID AND J.JOB_TITLE = titluJobParametru;

BEGIN

	OPEN C1;

	LOOP
		FETCH C1 INTO titluJob;
		EXIT WHEN C1%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('TITLU JOB: ' || titluJob);
		DBMS_OUTPUT.PUT_LINE(' ');

		OPEN C2(titluJob);

		v_cont := 0;

		LOOP

			FETCH C2 INTO auxNume, auxSalariu;
			EXIT WHEN C2%NOTFOUND;

			DBMS_OUTPUT.PUT('Nume: ' || auxNume);
			IF(auxSalariu IS NOT NULL) THEN
				DBMS_OUTPUT.PUT_LINE(' - salariu: ' || auxSalariu);
			ELSE
				DBMS_OUTPUT.PUT_LINE(' - salariu: N/A');
			END IF;
		
			v_cont := v_cont + 1;

		END LOOP;

		IF v_cont = 0 THEN
			DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu jobul ' || titluJob);
		END IF;

		CLOSE C2;

	END LOOP;

	CLOSE C1;

	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;
/



-- b. ciclu cursoare
DECLARE

	titluJob JOBS.JOB_TITLE%TYPE;

	auxNume EMPLOYEES.LAST_NAME%TYPE;
	auxSalariu EMPLOYEES.SALARY%TYPE;

	v_cont NUMBER(6) := 0;

	CURSOR C1B IS
	SELECT 
		DISTINCT JOB_TITLE
	FROM JOBS;

	CURSOR C2B(titluJobParametru JOBS.JOB_TITLE%TYPE) IS
	SELECT
		E.LAST_NAME AS NUME,
		E.SALARY AS SALARIU
	FROM EMPLOYEES E, JOBS J
	WHERE E.JOB_ID = J.JOB_ID AND J.JOB_TITLE = titluJobParametru;

BEGIN



	OPEN C1B;

	LOOP

		FETCH C1B INTO titluJob;
		EXIT WHEN C1B%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('TITLU JOB: ' || titluJob);
		DBMS_OUTPUT.PUT_LINE(' ');

		v_cont := 0;

		FOR inregistrare IN C2B(titluJob) LOOP

			auxNume := inregistrare.NUME;
			auxSalariu := inregistrare.SALARIU;

			DBMS_OUTPUT.PUT('Nume: ' || auxNume);
			IF(auxSalariu IS NOT NULL) THEN
				DBMS_OUTPUT.PUT_LINE(' - salariu: ' || auxSalariu);
			ELSE
				DBMS_OUTPUT.PUT_LINE(' - salariu: N/A');
			END IF;
		
			v_cont := v_cont + 1;

		END LOOP;

		IF v_cont = 0 THEN
			DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu jobul ' || titluJob);
		END IF;

	END LOOP;

	CLOSE C1B;

	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;
/


-- c. ciclu cursoare cu subcereri
DECLARE

	titluJob JOBS.JOB_TITLE%TYPE;

	auxNume EMPLOYEES.LAST_NAME%TYPE;
	auxSalariu EMPLOYEES.SALARY%TYPE;

	v_cont NUMBER(6) := 0;

BEGIN

	FOR titluFor in ( SELECT DISTINCT JOB_TITLE FROM JOBS ) LOOP

		titluJob := titluFor.JOB_TITLE;

		DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('TITLU JOB: ' || titluJob);
		DBMS_OUTPUT.PUT_LINE(' ');

		v_cont := 0;

		FOR inregistrare IN (
			SELECT
				E.LAST_NAME AS NUME,
				E.SALARY AS SALARIU
			FROM EMPLOYEES E, JOBS J
			WHERE E.JOB_ID = J.JOB_ID AND J.JOB_TITLE = titluJob
		) LOOP

			auxNume := inregistrare.NUME;
			auxSalariu := inregistrare.SALARIU;

			DBMS_OUTPUT.PUT('Nume: ' || auxNume);
			IF(auxSalariu IS NOT NULL) THEN
				DBMS_OUTPUT.PUT_LINE(' - salariu: ' || auxSalariu);
			ELSE
				DBMS_OUTPUT.PUT_LINE(' - salariu: N/A');
			END IF;
		
			v_cont := v_cont + 1;

		END LOOP;

		IF v_cont = 0 THEN
			DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu jobul ' || titluJob);
		END IF;

	END LOOP;

	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;
/


-- d. expresii cursor
DECLARE

	titluJob JOBS.JOB_TITLE%TYPE;

	auxNume EMPLOYEES.LAST_NAME%TYPE;
	auxSalariu EMPLOYEES.SALARY%TYPE;

	v_cont NUMBER(6) := 0;

	CURSOR C is
	SELECT
		DISTINCT JOB_TITLE,
		CURSOR(
			SELECT
				E.LAST_NAME AS NUME,
				E.SALARY AS SALARIU
			FROM EMPLOYEES E, JOBS J1
			WHERE E.JOB_ID = J1.JOB_ID AND J1.JOB_TITLE = J2.JOB_TITLE
		) AS CURSOR_IMBRICAT
	FROM JOBS J2;

	v_cursor SYS_REFCURSOR;

BEGIN

	OPEN C;

	LOOP

		FETCH C INTO titluJob, v_cursor;
		EXIT WHEN C%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('TITLU JOB: ' || titluJob);
		DBMS_OUTPUT.PUT_LINE(' ');

		v_cont := 0;

		LOOP

			FETCH v_cursor INTO auxNume, auxSalariu;
			EXIT WHEN v_cursor%NOTFOUND;

			DBMS_OUTPUT.PUT('Nume: ' || auxNume);
			IF(auxSalariu IS NOT NULL) THEN
				DBMS_OUTPUT.PUT_LINE(' - salariu: ' || auxSalariu);
			ELSE
				DBMS_OUTPUT.PUT_LINE(' - salariu: N/A');
			END IF;
		
			v_cont := v_cont + 1;

		END LOOP;

		IF v_cont = 0 THEN
			DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu jobul ' || titluJob);
		END IF;

	END LOOP;

	CLOSE C;

	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;
/
