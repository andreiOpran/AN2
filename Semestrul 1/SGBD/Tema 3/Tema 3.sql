SET SERVEROUTPUT ON;

-- E1
-- Mențineți într-o colecție codurile celor mai prost plătiți 5 angajați care nu câștigă comision.
-- Folosind această colecție măriți cu 5% salariul acestor angajați. Afișați valoarea veche a salariului,
-- respectiv valoarea nouă a salariului. 


DECLARE

	TYPE tablou_indexat IS TABLE OF EMP_AO.SALARY%TYPE INDEX BY PLS_INTEGER;
	id_angajati tablou_indexat;
	salarii_vechi tablou_indexat;
	salarii_noi tablou_indexat;

BEGIN

	-- extragere id-uri angajati si salarii vechi
	SELECT
		EMPLOYEE_ID, SALARY
	BULK COLLECT INTO id_angajati, salarii_vechi
	FROM (
		SELECT
			EMPLOYEE_ID, SALARY
		FROM EMP_AO
		WHERE COMMISSION_PCT IS NULL
		ORDER BY SALARY
	)
	WHERE ROWNUM <= 5;

	-- actualizare salarii
	FOR i IN 1..id_angajati.COUNT LOOP
		UPDATE EMP_AO
		SET SALARY = salarii_vechi(i) * 1.05
		WHERE EMPLOYEE_ID = id_angajati(i);
	END LOOP;

	-- extragere salarii noi
	FOR i IN 1..id_angajati.COUNT LOOP
		SELECT
			SALARY
		INTO salarii_noi(i)
		FROM EMP_AO
		WHERE EMPLOYEE_ID = id_angajati(i);
	END LOOP;

	-- afisare
	FOR i IN 1..id_angajati.COUNT LOOP
		DBMS_OUTPUT.PUT_LINE('ID angajat: ' || id_angajati(i));
		DBMS_OUTPUT.PUT_LINE('Salariu vechi: ' || salarii_vechi(i));
		DBMS_OUTPUT.PUT_LINE('Salariu nou: ' || salarii_noi(i));
		DBMS_OUTPUT.PUT_LINE(' ');
	END LOOP;

	ROLLBACK;

END;
/





-- E2
-- Definiți un tip colecție denumit tip_orase_***. Creați tabelul excursie_*** cu următoarea
-- structură: cod_excursie NUMBER(4), denumire VARCHAR2(20), orase tip_orase_*** (ce va
-- conține lista orașelor care se vizitează într-o excursie, într-o ordine stabilită; de exemplu, primul
-- oraș din listă va fi primul oraș vizitat), status (disponibilă sau anulată).
-- a. Inserați 5 înregistrări în tabel.
-- b. Actualizați coloana orase pentru o excursie specificată:
-- - adăugați un oraș nou în listă, ce va fi ultimul vizitat în excursia respectivă;
-- - adăugați un oraș nou în listă, ce va fi al doilea oraș vizitat în excursia respectivă;
-- - inversați ordinea de vizitare a două dintre orașe al căror nume este specificat;
-- - eliminați din listă un oraș al cărui nume este specificat.


DECLARE

	TYPE tip_orase_ao IS TABLE OF VARCHAR(256);
	TYPE excursie_ao IS RECORD(
		cod_excursie NUMBER(4),
		denumire VARCHAR2(20),
		orase tip_orase_ao,
		status BOOLEAN DEFAULT TRUE -- TRUE = DISPONIBILA, FALSE = ANULATA
	);

	TYPE tabel_excursie_ao IS TABLE OF excursie_ao INDEX BY BINARY_INTEGER;
	t tabel_excursie_ao;

	cod_excursie NUMBER(4) := &cod;
	oras_nou_1 varchar2(20) := '&primul_oras_nou';
	oras_nou_2 varchar2(20) := '&al_doilea_oras_nou';

	inversare_1 varchar2(20) := '&oras_1';
	inversare_2 varchar2(20) := '&oras_2';
	ok1 BOOLEAN := FALSE;
	ok2 BOOLEAN := FALSE;

	oras_de_sters varchar2(20) := '&oras_de_sters';
	ok3 BOOLEAN := FALSE;

	EROARE_INVERSARE EXCEPTION;
	EROARE_STERGERE EXCEPTION;

BEGIN
	t(1).cod_excursie := 1;
	t(1).denumire := 'Excursie 1';
	t(1).orase := tip_orase_ao('Bucuresti', 'Cluj-Napoca', 'Iasi');
	t(1).status := TRUE;

	t(2).cod_excursie := 2;
	t(2).denumire := 'Excursie 2';
	t(2).orase := tip_orase_ao('Constanta', 'Timisoara', 'Brasov', 'Craiova');
	t(2).status := TRUE;

	t(3).cod_excursie := 3;
	t(3).denumire := 'Excursie 3';
	t(3).orase := tip_orase_ao('Galati', 'Oradea');
	t(3).status := FALSE;

	t(4).cod_excursie := 4;
	t(4).denumire := 'Excursie 4';
	t(4).orase := tip_orase_ao('Ploiesti', 'Campina', 'Busteni');
	t(4).status := TRUE;

	t(5).cod_excursie := 5;
	t(5).denumire := 'Excursie 5';
	t(5).orase := tip_orase_ao('Bacau', 'Focsani');
	t(5).status := FALSE;

	-- -- adaugare oras in excursia cu cod-ul "cod_excursie"
	t(cod_excursie).orase.EXTEND;
	t(cod_excursie).orase(t(cod_excursie).orase.COUNT) := oras_nou_1;

	-- -- adaugarea a altui oras in excursia cu cod-ul "cod_excursie"
	t(cod_excursie).orase.EXTEND;
	t(cod_excursie).orase(t(cod_excursie).orase.COUNT) := oras_nou_2;


	-- inversarea a doua orase specificate
	FOR i IN 1..t(cod_excursie).orase.COUNT LOOP
		IF t(cod_excursie).orase(i) = inversare_1 THEN
			t(cod_excursie).orase(i) := inversare_2;
			ok1 := TRUE; 
		ELSIF t(cod_excursie).orase(i) = inversare_2 THEN
			t(cod_excursie).orase(i) := inversare_1;
			ok2 := TRUE;
		END IF;
	END LOOP;
	IF NOT ok1 OR NOT ok2 THEN
		RAISE EROARE_INVERSARE;
	END IF;


	-- eliminati un oras specificat
	FOR i IN 1..t(cod_excursie).orase.COUNT LOOP
		IF t(cod_excursie).orase(i) = oras_de_sters THEN
			FOR j in i..t(cod_excursie).orase.COUNT-1 LOOP
				t(cod_excursie).orase(j) := t(cod_excursie).orase(j+1);
			END LOOP;
			t(cod_excursie).orase.DELETE(t(cod_excursie).orase.COUNT);
		ok3 := TRUE;
		EXIT; -- altfel nu functioneaza pentru stergerea primului oras din lista
		END IF;
	END LOOP;
	IF NOT ok3 THEN
		RAISE EROARE_STERGERE;
	END IF;

	-- afisare
	FOR i IN 1..t.COUNT LOOP
		DBMS_OUTPUT.PUT_LINE('EXCURSIA CU CODUL ' || t(i).cod_excursie || ':');
		DBMS_OUTPUT.PUT_LINE('DENUMIRE: ' || t(i).denumire);
		DBMS_OUTPUT.PUT('ORASE: ');
		FOR j IN 1..t(i).orase.COUNT LOOP
			DBMS_OUTPUT.PUT(t(i).orase(j) || ' ');
		END LOOP;
		DBMS_OUTPUT.NEW_LINE;
		DBMS_OUTPUT.PUT_LINE('STATUS: ' || CASE WHEN t(i).status THEN 'Disponibila' ELSE 'Anulata' END);
		DBMS_OUTPUT.PUT_line(' ');

	END LOOP;

EXCEPTION
	WHEN EROARE_INVERSARE THEN
		DBMS_OUTPUT.PUT_LINE('Nu s-a putut efectua inversarea deoarece nu exista orasele specificate in excursia cu codul ' || cod_excursie);
	WHEN EROARE_STERGERE THEN
		DBMS_OUTPUT.PUT_LINE('Nu s-a putut efectua stergerea deoarece nu exista orasul specificat in excursia cu codul ' || cod_excursie);
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM || ' ' || SQLCODE);
END;
/



