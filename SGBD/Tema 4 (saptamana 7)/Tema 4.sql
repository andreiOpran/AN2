SET SERVEROUTPUT ON;

-- Definiți un tip colecție denumit tip_orase_***. Creați tabelul excursie_*** cu următoarea
-- structură: cod_excursie NUMBER(4), denumire VARCHAR2(20), orase tip_orase_*** (ce va
-- conține lista orașelor care se vizitează într-o excursie, într-o ordine stabilită; de exemplu, primul
-- oraș din listă va fi primul oraș vizitat), status (disponibilă sau anulată).

-- c. Pentru o excursie al cărui cod este dat, afișați numărul de orașe vizitate, respectiv numele orașelor.
-- d. Pentru fiecare excursie afișați lista orașelor vizitate.
-- e. Anulați excursiile cu cele mai puține orașe vizitate.


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

	cod_excursie NUMBER(4) := &cod_tastatura;
	exista_excursie BOOLEAN := FALSE;

	nu_exista_excursie EXCEPTION;

	minim NUMBER(4) := 9999;

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
	t(3).status := TRUE;

	t(4).cod_excursie := 4;
	t(4).denumire := 'Excursie 4';
	t(4).orase := tip_orase_ao('Ploiesti', 'Campina', 'Busteni');
	t(4).status := TRUE;

	t(5).cod_excursie := 5;
	t(5).denumire := 'Excursie 5';
	t(5).orase := tip_orase_ao('Bacau', 'Focsani');
	t(5).status := TRUE;



	-- c. Pentru o excursie al cărui cod este dat, afișați numărul de orașe vizitate, respectiv numele orașelor.

	-- verificare existenta excursie cu codul dat de la tastatura
	FOR i IN 1..t.COUNT LOOP
		IF t(i).cod_excursie = cod_excursie THEN
			exista_excursie := TRUE;
			EXIT;
		END IF;
	END LOOP;
	
	IF NOT exista_excursie THEN
		RAISE nu_exista_excursie;
	ELSE
		DBMS_OUTPUT.PUT_LINE('EXCURSIA ' || cod_excursie || ' ARE ' || t(cod_excursie).orase.COUNT || ' ORASE VIZITATE:');
		DBMS_OUTPUT.PUT('ORASELE VIZITATE SUNT: ');
		DBMS_OUTPUT.PUT_LINE(' ');
		FOR i IN 1..t(cod_excursie).orase.COUNT LOOP
			DBMS_OUTPUT.PUT_LINE(t(cod_excursie).orase(i));
		END LOOP;
	END IF;

	

	-- d. Pentru fiecare excursie afișați lista orașelor vizitate.
	IF t.COUNT = 0 then
		DBMS_OUTPUT.PUT_LINE('NU EXISTA EXCURSII.');
	ELSE
		FOR i in 1..t.COUNT LOOP
			DBMS_OUTPUT.PUT_LINE('LISTA DE ORASE VIZITATE PENTRU EXCURSIA CU CODUL ' || t(i).cod_excursie || ':');
			FOR j in 1..t(i).orase.COUNT LOOP
				DBMS_OUTPUT.PUT(t(i).orase(j));
				DBMS_OUTPUT.PUT(' ');
			END LOOP;
			DBMS_OUTPUT.PUT_LINE(' ');
			DBMS_OUTPUT.PUT_LINE(' ');
		END LOOP; 
	END IF;



	-- e. Anulați excursiile cu cele mai puține orașe vizitate.

	-- determinare numar minim de orase vizitate
	FOR i in 1..t.COUNT LOOP
		IF t(i).orase.COUNT < minim THEN
			minim := t(i).orase.COUNT;
		END IF;
	END LOOP;

	-- anulare excursii cu numar minim de orase vizitate
	FOR i in 1..t.COUNT LOOP
		IF t(i).orase.COUNT = minim THEN
			t(i).status := FALSE;
		END IF;
	END LOOP;
	


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
	WHEN nu_exista_excursie THEN
		DBMS_OUTPUT.PUT_LINE('Excursia cu codul ' || cod_excursie || ' nu exista.');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM || ' ' || SQLCODE);
END;
/





-- E3. Rezolvați problema anterioară folosind un alt tip de colecție studiat

-- a. Inserați 5 înregistrări în tabel.
-- b. Actualizați coloana orase pentru o excursie specificată:
-- - adăugați un oraș nou în listă, ce va fi ultimul vizitat în excursia respectivă;
-- - adăugați un oraș nou în listă, ce va fi al doilea oraș vizitat în excursia respectivă;
-- - inversați ordinea de vizitare a două dintre orașe al căror nume este specificat;
-- - eliminați din listă un oraș al cărui nume este specificat.
-- c. Pentru o excursie al cărui cod este dat, afișați numărul de orașe vizitate, respectiv numele
-- orașelor.
-- d. Pentru fiecare excursie afișați lista orașelor vizitate.
-- e. Anulați excursiile cu cele mai puține orașe vizitate.

DECLARE

	TYPE varray_tip_orase_ao IS VARRAY(20) OF VARCHAR(256);
	TYPE excursie_ao IS RECORD(
		cod_excursie NUMBER(4),
		denumire VARCHAR2(20),
		orase varray_tip_orase_ao,
		status BOOLEAN DEFAULT TRUE -- TRUE = DISPONIBILA, FALSE = ANULATA
	);

	TYPE varray_excursie_ao IS VARRAY(20) OF excursie_ao;
	v varray_excursie_ao := varray_excursie_ao();

	-- b. variabile
	cod_excursie NUMBER(4) := &varray_cod_tastatura;

	oras_nou_1 varchar2(20) := '&varray_primul_oras_nou';
	oras_nou_2 varchar2(20) := '&varray_al_doilea_oras_nou';
	
	inversare_1 varchar2(20) := '&varray_inversare_1';
	inversare_2 varchar2(20) := '&varray_inversare_2';
	index_inversare_1 NUMBER(2) := -1;
	index_inversare_2 NUMBER(2) := -1;
	ok1 BOOLEAN := FALSE;
	ok2 BOOLEAN := FALSE;
	eroare_inversare EXCEPTION;

	oras_de_sters varchar2(20) := '&varray_oras_de_sters';
	ok3 BOOLEAN := FALSE;
	eroare_stergere EXCEPTION;

	-- c. variabile
	exista_excursie BOOLEAN := FALSE;
	nu_exista_excursie EXCEPTION;

	-- e. variabile
	minim NUMBER(4) := 9999;

BEGIN

	-- a. Inserați 5 înregistrări în tabel.
	
	v.EXTEND(5);
	
	v(1).cod_excursie := 1;
	v(1).denumire := 'Excursie 1';
	v(1).orase := varray_tip_orase_ao('Bucuresti', 'Cluj-Napoca', 'Iasi');
	v(1).status := TRUE;

	v(2).cod_excursie := 2;
	v(2).denumire := 'Excursie 2';
	v(2).orase := varray_tip_orase_ao('Constanta', 'Timisoara', 'Brasov', 'Craiova');
	v(2).status := TRUE;

	v(3).cod_excursie := 3;
	v(3).denumire := 'Excursie 3';
	v(3).orase := varray_tip_orase_ao('Galati', 'Oradea');
	v(3).status := TRUE;

	v(4).cod_excursie := 4;
	v(4).denumire := 'Excursie 4';
	v(4).orase := varray_tip_orase_ao('Ploiesti', 'Campina', 'Busteni');
	v(4).status := TRUE;

	v(5).cod_excursie := 5;
	v(5).denumire := 'Excursie 5';
	v(5).orase := varray_tip_orase_ao('Bacau', 'Focsani');
	v(5).status := TRUE;


	-- b. Actualizați coloana orase pentru o excursie specificată:
	
	-- - adăugați un oraș nou în listă, ce va fi ultimul vizitat în excursia respectivă;

	v(cod_excursie).orase.EXTEND;
	v(cod_excursie).orase(v(cod_excursie).orase.LAST) := oras_nou_1;

	-- - adăugați un oraș nou în listă, ce va fi al doilea oraș vizitat în excursia respectivă;

	v(cod_excursie).orase.EXTEND;
	v(cod_excursie).orase(v(cod_excursie).orase.LAST) := oras_nou_2;

	-- - inversați ordinea de vizitare a două dintre orașe al căror nume este specificat;
	FOR i in 1..v(cod_excursie).orase.COUNT LOOP
		IF upper(v(cod_excursie).orase(i)) = upper(inversare_1) THEN
			ok1 := TRUE;
			index_inversare_1 := i; -- salvam doar index-ul pentru ca daca modificam direct cum am facut la tema 3, se poate ca inversarea sa nu se faca pana la final
		ELSIF upper(v(cod_excursie).orase(i)) = upper(inversare_2) THEN
			ok2 := TRUE;
			index_inversare_2 := i; -- salvam doar index-ul pentru ca daca modificam direct cum am facut la tema 3, se poate ca inversarea sa nu se faca pana la final
		END IF;
	END LOOP;

	IF ok1 AND ok2 THEN
		v(cod_excursie).orase(index_inversare_1) := inversare_2; -- facem inversarea folosind indexii memorati
		v(cod_excursie).orase(index_inversare_2) := inversare_1;
	ELSE
		RAISE eroare_inversare;
	END IF;


	-- eliminați din listă un oraș al cărui nume este specificat.
	
	-- verificare existenta oras dat de la tastatura
	FOR i in 1..v.COUNT LOOP
		IF upper(v(cod_excursie).orase(i)) = upper(oras_de_sters) THEN
			ok3 := TRUE;
			FOR j in i..v(cod_excursie).orase.COUNT-1 LOOP
				v(cod_excursie).orase(j) := v(cod_excursie).orase(j+1);
			END LOOP;
			v(cod_excursie).orase.TRIM;
			EXIT;
		END IF;
	END LOOP;

	IF NOT ok3 THEN
		RAISE eroare_stergere;
	END IF;

	-- c. Pentru o excursie al cărui cod este dat, afișați numărul de orașe vizitate, respectiv numele orașelor.

	-- verificare existenta excursie cu codul dat de la tastatura
	FOR i IN 1..v.COUNT LOOP
		IF v(i).cod_excursie = cod_excursie THEN
			exista_excursie := TRUE;
			EXIT;
		END IF;
	END LOOP;
	
	IF NOT exista_excursie THEN
		RAISE nu_exista_excursie;
	ELSE
		DBMS_OUTPUT.PUT_LINE('EXCURSIA ' || cod_excursie || ' ARE ' || v(cod_excursie).orase.COUNT || ' ORASE VIZITATE:');
		DBMS_OUTPUT.PUT('ORASELE VIZITATE SUNT: ');
		DBMS_OUTPUT.PUT_LINE(' ');
		FOR i IN 1..v(cod_excursie).orase.COUNT LOOP
			DBMS_OUTPUT.PUT_LINE(v(cod_excursie).orase(i));
		END LOOP;
	END IF;


	-- d. Pentru fiecare excursie afișați lista orașelor vizitate.

	IF v.COUNT = 0 then
		DBMS_OUTPUT.PUT_LINE('NU EXISTA EXCURSII.');
	ELSE
		FOR i in 1..v.COUNT LOOP
			DBMS_OUTPUT.PUT_LINE('LISTA DE ORASE VIZITATE PENTRU EXCURSIA CU CODUL ' || v(i).cod_excursie || ':');
			FOR j in 1..v(i).orase.COUNT LOOP
				DBMS_OUTPUT.PUT(v(i).orase(j));
				DBMS_OUTPUT.PUT(' ');
			END LOOP;
			DBMS_OUTPUT.PUT_LINE(' ');
			DBMS_OUTPUT.PUT_LINE(' ');
		END LOOP; 
	END IF;

	-- e. Anulați excursiile cu cele mai puține orașe vizitate.

	-- determinare numar minim de orase vizitate
	FOR i in 1..v.COUNT LOOP
		IF v(i).orase.COUNT < minim THEN
			minim := v(i).orase.COUNT;
		END IF;
	END LOOP;

	-- anulare excursii cu numar minim de orase vizitate
	FOR i in 1..v.COUNT LOOP
		IF v(i).orase.COUNT = minim THEN
			v(i).status := FALSE;
		END IF;
	END LOOP;

	-- afisare excursii
	FOR i IN 1..v.COUNT LOOP
		DBMS_OUTPUT.PUT_LINE('EXCURSIA CU CODUL ' || v(i).cod_excursie || ':');
		DBMS_OUTPUT.PUT_LINE('DENUMIRE: ' || v(i).denumire);
		DBMS_OUTPUT.PUT('ORASE: ');
		FOR j IN 1..v(i).orase.COUNT LOOP
			DBMS_OUTPUT.PUT(v(i).orase(j) || ' ');
		END LOOP;
		DBMS_OUTPUT.NEW_LINE;
		DBMS_OUTPUT.PUT_LINE('STATUS: ' || CASE WHEN v(i).status THEN 'Disponibila' ELSE 'Anulata' END);
		DBMS_OUTPUT.PUT_LINE(' ');
	END LOOP;


EXCEPTION
	WHEN eroare_inversare THEN
		DBMS_OUTPUT.PUT_LINE('Nu s-a putut efectua inversarea deoarece nu exista orasele specificate in excursia cu codul ' || cod_excursie);
	WHEN eroare_stergere THEN
		DBMS_OUTPUT.PUT_LINE('Nu s-a putut efectua stergerea deoarece nu exista orasul specificat in excursia cu codul ' || cod_excursie);
	WHEN nu_exista_excursie THEN
		DBMS_OUTPUT.PUT_LINE('Excursia cu codul ' || cod_excursie || ' nu exista.');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM || ' ' || SQLCODE);
END;
/




