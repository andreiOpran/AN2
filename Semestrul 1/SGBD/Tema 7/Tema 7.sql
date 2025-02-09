SET SERVEROUTPUT ON;

-- E1

-- Creați tabelul info_ao cu următoarele coloane:
-- - utilizator (numele utilizatorului care a inițiat o comandă)
-- - data (data și timpul la care utilizatorul a inițiat comanda)
-- - comanda (comanda care a fost inițiată de utilizatorul respectiv)
-- - nr_linii (numărul de linii selectate/modificate de comandă)
-- - eroare (un mesaj pentru excepții).

CREATE TABLE INFO_AO (
    UTILIZATOR VARCHAR2(128),
    DATA DATE,
    COMANDA VARCHAR2(128),
    NR_LINII NUMBER(6),
    EROARE VARCHAR2(128)
);


-- E5

-- Definiți un subprogram care obține pentru fiecare nume de departament ziua din săptămână în
-- care au fost angajate cele mai multe persoane, lista cu numele acestora, vechimea și venitul lor
-- lunar. Afișați mesaje corespunzătoare următoarelor cazuri:
-- - într-un departament nu lucrează niciun angajat;
-- - într-o zi din săptămână nu a fost nimeni angajat.
-- 
-- Observații:
-- a. Numele departamentului și ziua apar o singură dată în rezultat.
-- b. Rezolvați problema în două variante, după cum se ține cont sau nu de istoricul joburilor
-- angajaților.

CREATE OR REPLACE PROCEDURE E5_AO IS
    
    v_departament_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;

    CURSOR c_departamente IS
        SELECT
            DEPARTMENT_ID,
            DEPARTMENT_NAME,
            MANAGER_ID
        FROM DEPARTMENTS;

    CURSOR c_zi_angajare_maxima (p_department_id DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
        SELECT * FROM (
            SELECT
                TO_CHAR(HIRE_DATE, 'DAY') AS zi_angajare_maxima,
                HIRE_DATE AS data_angajare_maxima,
                COUNT(*) AS numar_angajari
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID = p_department_id
            GROUP BY HIRE_DATE
            ORDER BY numar_angajari DESC
            )
            WHERE ROWNUM = 1;

    CURSOR c_anjagati (p_department_id DEPARTMENTS.DEPARTMENT_ID%TYPE, p_data_angajare_maxima VARCHAR2) IS
        SELECT
            FIRST_NAME,
            LAST_NAME,
            HIRE_DATE,
            ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12, 0) AS vechime,
            SALARY
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = p_department_id AND HIRE_DATE = p_data_angajare_maxima;

BEGIN

    FOR inregistrare_departamente in c_departamente LOOP

        IF(inregistrare_departamente.MANAGER_ID IS NULL) THEN
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE(inregistrare_departamente.DEPARTMENT_NAME || ' -> nu are angajati');
        END IF;

        FOR inregistrare_zi_angajare_maxima IN c_zi_angajare_maxima(inregistrare_departamente.DEPARTMENT_ID) LOOP

            v_departament_name := inregistrare_departamente.DEPARTMENT_NAME;

            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE(v_departament_name || ' -> ' || inregistrare_zi_angajare_maxima.zi_angajare_maxima || inregistrare_zi_angajare_maxima.data_angajare_maxima);

            FOR inregistrare_angajati IN c_anjagati(inregistrare_departamente.DEPARTMENT_ID, inregistrare_zi_angajare_maxima.data_angajare_maxima) LOOP
                DBMS_OUTPUT.PUT_LINE('NUME: ' || inregistrare_angajati.FIRST_NAME || ' ' || inregistrare_angajati.LAST_NAME || ' VECHIME: ' || inregistrare_angajati.vechime || ' ani SALARIU: ' || inregistrare_angajati.SALARY);
            END LOOP;

        END LOOP;
    
    END LOOP;

END E5_AO;
/

BEGIN
    E5_AO;
END;
/
