SET SERVEROUTPUT ON;

-- E1
-- Mențineți într-o colecție codurile celor mai prost plătiți 5 angajați care nu câștigă comision.
-- Folosind această colecție măriți cu 5% salariul acestor angajați. Afișați valoarea veche a salariului,
-- respectiv valoarea nouă a salariului. 




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
-- c. Pentru o excursie al cărui cod este dat, afișați numărul de orașe vizitate, respectiv numele
-- orașelor.
-- d. Pentru fiecare excursie afișați lista orașelor vizitate.
-- e. Anulați excursiile cu cele mai puține orașe vizitate.


DECLARE
	TYPE TIP_ORASE_AO IS TABLE OF VARCHAR(256);
	TYPE EXCURSIE_AO IS RECORD(
		COD_EXCURSIE NUMBER(6),
		DENUMIRE VARCHAR2(20),
		ORASE TIP_ORASE_AO,
		STATUS BOOLEAN DEFAULT TRUE -- TRUE = DISPONIBILA, FALSE = ANULATA
	);

	TABEL_EXCURSIE_AO IS TABLE OF EXCURSIE_AO INDEX BY BINARY_INTEGER;
	T TABEL_EXCURSIE_AO;

BEGIN



END
/
