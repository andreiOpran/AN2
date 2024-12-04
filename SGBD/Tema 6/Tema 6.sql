SET SERVEROUTPUT ON;

-- E2
-- Modificați exercițiul anterior astfel încât să obțineți și următoarele informații:
-- - un număr de ordine pentru fiecare angajat care va fi resetat pentru fiecare job
-- - pentru fiecare job
--     o numărul de angajați
--     o valoarea lunară a veniturilor angajaților
--     o valoarea medie a veniturilor angajaților
-- - indiferent job
--     o numărul total de angajați
--     o valoarea totală lunară a veniturilor angajaților
--     o valoarea medie a veniturilor angajaților

-- am ales sa fac cu ciclu cursor
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

	valoareLunaraPerJob NUMBER(10) := 0;

	valoareLunaraTotal NUMBER(10) := 0;
	numarAngajatiTotal NUMBER(6) := 0;

BEGIN

	FOR inregistrareOuter in C1 LOOP

		titluJob := inregistrareOuter.JOB_TITLE;

		DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('TITLU JOB: ' || titluJob);
		DBMS_OUTPUT.PUT_LINE(' ');

		v_cont := 0;
		valoareLunaraPerJob := 0;

		FOR inregistrare IN C2(titluJob) LOOP

			auxNume := inregistrare.NUME;
			auxSalariu := inregistrare.SALARIU;

			DBMS_OUTPUT.PUT(v_cont + 1 || '. Nume: ' || auxNume);
			IF(auxSalariu IS NOT NULL) THEN
				DBMS_OUTPUT.PUT_LINE(' - salariu: ' || auxSalariu);
			ELSE
				DBMS_OUTPUT.PUT_LINE(' - salariu: N/A');
				auxSalariu := 0; -- initializare -> altfel se strica calculele pentru valoarea lunara 
			END IF;
		
			v_cont := v_cont + 1;
			numarAngajatiTotal := numarAngajatiTotal + 1;

			valoareLunaraPerJob := valoareLunaraPerJob + auxSalariu;

			valoareLunaraTotal := valoareLunaraTotal + auxSalariu;

		END LOOP;

		IF v_cont = 0 THEN
			DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu jobul ' || titluJob);
			DBMS_OUTPUT.PUT_LINE('Numarul de angajati: 0');
			DBMS_OUTPUT.PUT_LINE('Valoare lunara a veniturilor angajatilor: 0');
			DBMS_OUTPUT.PUT_LINE('Valoare medie a veniturilor angajatilor: 0');
		ELSE
			DBMS_OUTPUT.PUT_LINE(' ');
			DBMS_OUTPUT.PUT_LINE('Numarul de angajati: ' || v_cont);
			DBMS_OUTPUT.PUT_LINE('Valoare lunara a veniturilor angajatilor: ' || valoareLunaraPerJob);
			DBMS_OUTPUT.PUT_LINE('Valoare medie a veniturilor angajatilor: ' || valoareLunaraPerJob / v_cont);
		END IF;

	END LOOP;

	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('INFORMATII DATE INDIFERENT DE JOB:');
	DBMS_OUTPUT.PUT_LINE(' ');
	DBMS_OUTPUT.PUT_LINE('Numarul total de angajati: ' || numarAngajatiTotal);
	DBMS_OUTPUT.PUT_LINE('Valoare totala lunara a veniturilor angajatilor: ' || valoareLunaraTotal);
	DBMS_OUTPUT.PUT_LINE('Valoare medie a veniturilor angajatilor: ' || ROUND(valoareLunaraTotal / numarAngajatiTotal, 3)); -- am pus doar 3 zecimale
	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

END;
/


-- E3
-- Modificați exercițiul anterior astfel încât să obțineți suma totală alocată lunar pentru plata
-- salariilor și a comisioanelor tuturor angajaților, iar pentru fiecare angajat cât la sută din această
-- sumă câștigă lunar. 

DECLARE

	titluJob JOBS.JOB_TITLE%TYPE;

	auxPrenume EMPLOYEES.FIRST_NAME%TYPE;
	auxNume EMPLOYEES.LAST_NAME%TYPE;
	auxSalariu EMPLOYEES.SALARY%TYPE;
	auxComision EMPLOYEES.COMMISSION_PCT%TYPE;

	v_cont NUMBER(6) := 0;

	CURSOR C1 IS
	SELECT 
		DISTINCT JOB_TITLE
	FROM JOBS;

	CURSOR C2(titluJobParametru JOBS.JOB_TITLE%TYPE) IS
	SELECT
		E.LAST_NAME AS NUME,
		E.SALARY AS SALARIU,
		E.COMMISSION_PCT AS COMISION
	FROM EMPLOYEES E, JOBS J
	WHERE E.JOB_ID = J.JOB_ID AND J.JOB_TITLE = titluJobParametru;

	CURSOR C3 IS
	SELECT
		E.FIRST_NAME AS PRENUME,
		E.LAST_NAME AS NUME,
		E.SALARY AS SALARIU,
		E.COMMISSION_PCT AS COMISION
	FROM EMPLOYEES E;

	valoareSalariuLunarTotal NUMBER(10) := 0;
	valoareComisionLunarTotal NUMBER(10) := 0;
	numarAngajatiTotal NUMBER(6) := 0;
	valoareTotalaAlocata NUMBER(10) := 0;

	comisionCalculat NUMBER(10) := 0;

	rezultat BINARY_FLOAT := 0;

BEGIN

	FOR inregistrareOuter in C1 LOOP

		titluJob := inregistrareOuter.JOB_TITLE;

		FOR inregistrare IN C2(titluJob) LOOP

			auxNume := inregistrare.NUME;
			auxSalariu := inregistrare.SALARIU;
			auxComision := inregistrare.COMISION;

			IF(auxSalariu is NULL) THEN
				auxSalariu := 0;
			END IF;
			IF(auxComision is NULL) THEN
				auxComision := 0;
			END IF;
			
			numarAngajatiTotal := numarAngajatiTotal + 1;
			valoareSalariuLunarTotal := valoareSalariuLunarTotal + auxSalariu;
			valoareComisionLunarTotal := valoareComisionLunarTotal + auxSalariu * auxComision;

		END LOOP;

	END LOOP;

	valoareTotalaAlocata := valoareSalariuLunarTotal + valoareComisionLunarTotal;

	DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Suma totala alocata lunar pentru plata salariilor: ' || valoareSalariuLunarTotal);
	DBMS_OUTPUT.PUT_LINE('Suma totala alocata lunar pentru plata comisioanelor: ' || valoareComisionLunarTotal);
	DBMS_OUTPUT.PUT_LINE('Suma totala alocata lunar: ' || valoareTotalaAlocata);
	DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE(' ');

	v_cont := 0;
	FOR angajat IN C3 LOOP

		auxPrenume := angajat.PRENUME;
		auxNume := angajat.NUME;
		auxSalariu := angajat.SALARIU;
		auxComision := angajat.COMISION;

		IF(auxSalariu is NULL) THEN
			auxSalariu := 0;
		END IF;
		IF(auxComision is NULL) THEN
			auxComision := 0;
		END IF;

		comisionCalculat := auxSalariu * auxComision;
		auxSalariu := auxSalariu + comisionCalculat;

		rezultat := (auxSalariu / valoareTotalaAlocata) * 100;



		v_cont := v_cont + 1;

		-- mai multe cazuri pentru afisare corecta a procentajului; FM sterge spatiile automate din fata TO_CHAR
		IF(auxSalariu = 0) THEN
			DBMS_OUTPUT.PUT_LINE(v_cont || '. ' || UPPER(auxPrenume) || ' ' || UPPER(auxNume) || ' castiga 0% din suma totala.');
		ELSIF(rezultat < 1) THEN
			DBMS_OUTPUT.PUT_LINE(v_cont || '. ' || UPPER(auxPrenume) || ' ' || UPPER(auxNume) || ' castiga 0' || TO_CHAR(REZULTAT, 'FM9.9999') || '% din suma totala.');
		ELSE
			DBMS_OUTPUT.PUT_LINE(v_cont || '. ' || UPPER(auxPrenume) || ' ' || UPPER(auxNume) || ' castiga ' || TO_CHAR(REZULTAT, 'FM99.9999') || '% din suma totala.');
		END IF;

	END LOOP;

END;
/
