SET SERVEROUTPUT ON;
------------------------------------------------ EX1 ---------------------------------------------------


-- Folosind 2 cursoare (dintre care unul sa fie parametrizat), afisati datile in care
-- un membru a rezervat un film care nu este disponibil pentru inchiriat in acest moment

DECLARE
    CURSOR c1 IS -- cursorul c1 va memora toti membrii
        SELECT 
            distinct MEMBER_ID
        FROM MEMBER_LBC;

    CURSOR c2 (v_member_id NUMBER) IS -- cursorul c2 va memora cand a inchiriat un membru un film care nu este disponibil momentan
    SELECT 
        DISTINCT R.BOOK_DATE
    FROM RENTAL_LBC R
    JOIN TITLE_COPY_LBC TC ON R.TITLE_ID = TC.TITLE_ID
    WHERE R.MEMBER_ID = v_member_id AND UPPER(TC.STATUS) != 'AVAILABLE';

    v_member_id MEMBER_LBC.MEMBER_ID%TYPE;
    v_book_date RENTAL_LBC.BOOK_DATE%TYPE;

    TYPE rezultat IS TABLE OF RENTAL_LBC.BOOK_DATE%TYPE;
    v_rezultat rezultat := rezultat(); -- vector in care o sa memoram datele cerute
    v_ok BOOLEAN; -- verificare daca mai exista deja acea data in v_rezultat

BEGIN

    OPEN c1;

    LOOP

        FETCH c1 INTO v_member_id;
        EXIT WHEN c1%NOTFOUND;

        OPEN c2(v_member_id);
    
        LOOP
            
            FETCH c2 INTO v_book_date;
            EXIT WHEN c2%NOTFOUND;
            
            v_ok := TRUE;
            FOR i IN 1..v_rezultat.COUNT LOOP -- verificam daca am memorat deja data curenta
                
                IF v_rezultat(i) = v_book_date THEN
                    v_ok := FALSE;
                    EXIT;
                END IF;

            END LOOP;

            IF v_ok THEN -- daca data este intalnita prima data atunci o memoram
                v_rezultat.EXTEND;
                v_rezultat(v_rezultat.COUNT) := v_book_date;
            END IF;


        END LOOP;
        CLOSE c2;

    END LOOP;
    CLOSE c1;

    FOR i IN 1..v_rezultat.COUNT LOOP -- afisam rezultatul
        DBMS_OUTPUT.PUT_LINE('Data ' || i || ': ' || v_rezultat(i));
    END LOOP;
    
END;
/



-- Folosind 2 cursoare clasice, afisati datile in care
-- un membru a rezervat un film care nu este disponibil pentru inchiriat in acest moment

DECLARE
    CURSOR c1 IS -- cursorul c1 va memora toti membrii
        SELECT 
            DISTINCT MEMBER_ID
        FROM MEMBER_LBC;

    CURSOR c2 IS -- cursorul c2 va memora cand a inchiriat un membru un film care nu este disponibil momentan
        SELECT 
            R.MEMBER_ID,
            R.BOOK_DATE
        FROM RENTAL_LBC R
        JOIN TITLE_COPY_LBC TC ON R.TITLE_ID = TC.TITLE_ID
        WHERE UPPER(TC.STATUS) != 'AVAILABLE';

    v_member_id MEMBER_LBC.MEMBER_ID%TYPE;
    v_member_id_2 RENTAL_LBC.MEMBER_ID%TYPE;
    v_book_date RENTAL_LBC.BOOK_DATE%TYPE;

    TYPE rezultat IS TABLE OF RENTAL_LBC.BOOK_DATE%TYPE;
    v_rezultat rezultat := rezultat(); -- vector in care o sa memoram datele cerute
    v_ok BOOLEAN; -- verificare daca mai exista deja acea data in v_rezultat

BEGIN

    OPEN c1;

    LOOP

        FETCH c1 INTO v_member_id;
        EXIT WHEN c1%NOTFOUND;

        OPEN c2;
    
        LOOP
            
            FETCH c2 INTO v_member_id_2, v_book_date;
            EXIT WHEN c2%NOTFOUND;
            
            IF v_member_id_2 = v_member_id THEN
                v_ok := TRUE;
                FOR i IN 1..v_rezultat.COUNT LOOP -- verificam daca am memorat deja data curenta
                    
                    IF v_rezultat(i) = v_book_date THEN
                        v_ok := FALSE;
                        EXIT;
                    END IF;

                END LOOP;

                IF v_ok THEN -- daca data este intalnita prima data atunci o memoram
                    v_rezultat.EXTEND;
                    v_rezultat(v_rezultat.COUNT) := v_book_date;
                END IF;
            END IF;

        END LOOP;
        CLOSE c2;

    END LOOP;
    CLOSE c1;

    
    FOR i IN 1..v_rezultat.COUNT LOOP -- afisam rezultatul
        DBMS_OUTPUT.PUT_LINE('Data ' || i || ': ' || v_rezultat(i));
    END LOOP;

END;
/




-- Folosind 2 ciclu cursoare, afisati datile in care
-- un membru a rezervat un film care nu este disponibil pentru inchiriat in acest moment

DECLARE
    CURSOR c1 IS -- cursorul c1 va memora toti membrii
        SELECT 
            DISTINCT MEMBER_ID
        FROM MEMBER_LBC;

    CURSOR c2 IS -- cursorul c2 va memora cand a inchiriat un membru un film care nu este disponibil momentan
        SELECT 
            R.MEMBER_ID,
            R.BOOK_DATE
        FROM RENTAL_LBC R
        JOIN TITLE_COPY_LBC TC ON R.TITLE_ID = TC.TITLE_ID
        WHERE UPPER(TC.STATUS) != 'AVAILABLE';

    v_member_id MEMBER_LBC.MEMBER_ID%TYPE;
    v_member_id_2 RENTAL_LBC.MEMBER_ID%TYPE;
    v_book_date RENTAL_LBC.BOOK_DATE%TYPE;

    TYPE rezultat IS TABLE OF RENTAL_LBC.BOOK_DATE%TYPE;
    v_rezultat rezultat := rezultat(); -- vector in care o sa memoram datele cerute
    v_ok BOOLEAN; -- verificare daca mai exista deja acea data in v_rezultat

BEGIN

    FOR inregistrare IN c1 LOOP

        v_member_id := inregistrare.MEMBER_ID; -- FETCH

        FOR inregistrare_2 IN c2 LOOP

            v_member_id_2 := inregistrare_2.MEMBER_ID; -- FETCH
            v_book_date := inregistrare_2.BOOK_DATE; -- FETCH

            IF v_member_id_2 = v_member_id THEN
                v_ok := TRUE;
                FOR i IN 1..v_rezultat.COUNT LOOP -- verificam daca am memorat deja data curenta

                    IF v_rezultat(i) = v_book_date THEN
                        v_ok := FALSE;
                        EXIT;
                    END IF;

                END LOOP;

                IF v_ok THEN -- daca data este intalnita prima data atunci o memoram
                    v_rezultat.EXTEND;
                    v_rezultat(v_rezultat.COUNT) := v_book_date;
                END IF;
            END IF;

        END LOOP;

    END LOOP;

    FOR i IN 1..v_rezultat.COUNT LOOP -- afisam rezultatul
        DBMS_OUTPUT.PUT_LINE('Data ' || i || ': ' || v_rezultat(i));
    END LOOP;

END;
/


-- Folosind 2 expresii cursor, afisati datile in care
-- un membru a rezervat un film care nu este disponibil pentru inchiriat in acest moment

DECLARE
    CURSOR c1 IS 
        SELECT 
            MEMBER_ID,
            CURSOR(
                SELECT DISTINCT R.BOOK_DATE
                FROM RENTAL_LBC R
                JOIN TITLE_COPY_LBC TC ON R.TITLE_ID = TC.TITLE_ID
                WHERE R.MEMBER_ID = MEMBER_LBC.MEMBER_ID AND UPPER(TC.STATUS) != 'AVAILABLE'
            ) AS c2
        FROM MEMBER_LBC;

    v_member_id MEMBER_LBC.MEMBER_ID%TYPE;
    v_book_date RENTAL_LBC.BOOK_DATE%TYPE;

    TYPE rezultat IS TABLE OF RENTAL_LBC.BOOK_DATE%TYPE;
    v_rezultat rezultat := rezultat(); -- vector in care o sa memoram datele cerute
    v_ok BOOLEAN; -- verificare daca mai exista deja acea data in v_rezultat

    v_cursor SYS_REFCURSOR; -- cursor imbricat

BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_member_id, v_cursor;
        EXIT WHEN c1%NOTFOUND;

        LOOP

            FETCH v_cursor INTO v_book_date;
            EXIT WHEN v_cursor%NOTFOUND;

            v_ok := TRUE;
            FOR i IN 1..v_rezultat.COUNT LOOP -- verificam daca am memorat deja data curenta
                
                IF v_rezultat(i) = v_book_date THEN
                    v_ok := FALSE;
                    EXIT;
                END IF;

            END LOOP;

            IF v_ok THEN -- daca data este intalnita prima data atunci o memoram
                v_rezultat.EXTEND;
                v_rezultat(v_rezultat.COUNT) := v_book_date;
            END IF;

        END LOOP;
        CLOSE v_cursor;

    END LOOP;
    CLOSE c1;

    
    FOR i IN 1..v_rezultat.COUNT LOOP -- afisam rezultatul
        DBMS_OUTPUT.PUT_LINE('Data ' || i || ': ' || v_rezultat(i));
    END LOOP;

END;
/


------------------------------------------------ EX2 ---------------------------------------------------

-- Pe schema video, exemplificati, ca la curs, ce se intampla cand avem doua sesiuni si folosim 
-- select...for update in prima sesiune, iar in a doua avem select...for update nowait/ wait n / skip locked.(Hint: Ex 5.11).

--sesiune 1
SELECT * FROM MEMBER_LBC
WHERE MEMBER_id=101 
FOR UPDATE;
commit;

SELECT * FROM MEMBER_LBC
WHERE MEMBER_id=101
FOR UPDATE NOWAIT;

SELECT * FROM MEMBER_LBC
WHERE MEMBER_id=102
FOR UPDATE NOWAIT;


--sesiune 2
SELECT * FROM MEMBER_LBC
WHERE MEMBER_id=101
FOR UPDATE NOWAIT;

SELECT * FROM MEMBER_LBC
WHERE MEMBER_id=102
FOR UPDATE NOWAIT;

SELECT * FROM MEMBER_LBC
WHERE MEMBER_id=103
FOR UPDATE NOWAIT;


-- daca suntem in sesiunea 1:
    -- putem rula toate 3 comenzile fara probleme

-- daca suntem in sesiunea 2 si am rulat prima comanda impreuna cu commit in sesiunea 1:
    -- nu vom putea rula a doua si a treia comanda deoarece sunt blocate de sesiunea 1 (de catre prima comanda cu commit) - vom primi eroare
    -- a treia cerere merge deoarece member_id = 103 nu a fost menionat in sesiunea 1

