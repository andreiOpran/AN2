CREATE OR REPLACE TRIGGER TRIG1_AO
    BEFORE INSERT OR UPDATE OR DELETE ON EMP_AO
BEGIN

    IF (TO_CHAR(SYSDATE,'D') = 1) OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 20) THEN
        RAISE_APPLICATION_ERROR(-20001,'tabelul nu poate fi actualizat');
    END IF;

END;
/

DELETE FROM EMP_AO
WHERE EMPLOYEE_ID = 102;

DROP TRIGGER TRIG1_AO;



CREATE OR REPLACE TRIGGER trig21_ao
    BEFORE UPDATE OF salary ON emp_ao
FOR EACH ROW
BEGIN
    IF (:NEW.salary < :OLD.salary) THEN
        RAISE_APPLICATION_ERROR(-20002,'salariul nu poate fi micsorat');
    END IF;
END;
/

UPDATE emp_ao
SET salary = salary - 100;

DROP TRIGGER trig21_ao;



-- 5

CREATE TABLE INFO_DEPT_ao (
    ID NUMBER(6) PRIMARY KEY,
    NUME_DEPT VARCHAR2(30),
    PLATI NUMBER(10)
);

CREATE TABLE INFO_EMP_ao (
    ID NUMBER(6) PRIMARY KEY,
    NUME VARCHAR2(30),
    PRENUME VARCHAR2(30),
    SALARIU NUMBER(10),
    ID_DEPT NUMBER(6),
    CONSTRAINT FK FOREIGN KEY (ID_DEPT) REFERENCES INFO_DEPT_ao(ID)
);

DROP TABLE INFO_DEPT_ao;
DROP TABLE INFO_EMP_ao;


CREATE OR REPLACE VIEW V_INFO_ao AS
    SELECT
        E.ID,
        E.NUME,
        E.PRENUME,
        E.SALARIU,
        E.ID_DEPT,
        D.NUME_DEPT,
        D.PLATI
    FROM INFO_EMP_ao E, INFO_DEPT_ao D
    WHERE E.ID_DEPT = D.ID;


SELECT * FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = UPPER('v_info_ao');


CREATE OR REPLACE TRIGGER TRIG5_ao INSTEAD OF
    INSERT OR DELETE OR UPDATE ON V_INFO_ao FOR EACH ROW
BEGIN
    IF INSERTING THEN
 
        -- inserarea in vizualizare determina inserarea
        -- in info_emp_ao si reactualizarea in info_dept_ao
        -- se presupune ca departamentul exista
        INSERT INTO INFO_EMP_ao VALUES (
            :NEW.ID,
            :NEW.NUME,
            :NEW.PRENUME,
            :NEW.SALARIU,
            :NEW.ID_DEPT
        );
        UPDATE INFO_DEPT_ao
        SET
            PLATI = PLATI + :NEW.SALARIU
        WHERE
            ID = :NEW.ID_DEPT;
    ELSIF DELETING THEN
 
        -- stergerea unui salariat din vizualizare determina
        -- stergerea din info_emp_ao si reactualizarea in
        -- info_dept_ao
        DELETE FROM INFO_EMP_ao
        WHERE
            ID = :OLD.ID;
        UPDATE INFO_DEPT_ao
        SET
            PLATI = PLATI - :OLD.SALARIU
        WHERE
            ID = :OLD.ID_DEPT;
    ELSIF UPDATING ('salariu') THEN
    /* modificarea unui salariu din vizualizare determina
    modificarea salariului in info_emp_ao si reactualizarea
    in info_dept_ao */
        UPDATE INFO_EMP_ao
        SET
            SALARIU = :NEW.SALARIU
        WHERE
            ID = :OLD.ID;
        UPDATE INFO_DEPT_ao
        SET
            PLATI = PLATI - :OLD.SALARIU + :NEW.SALARIU
        WHERE
            ID = :OLD.ID_DEPT;
    ELSIF UPDATING ('id_dept') THEN
    /* modificarea unui cod de departament din vizualizare
    determina modificarea codului in info_emp_ao
    si reactualizarea in info_dept_ao */
        UPDATE INFO_EMP_ao
        SET
            ID_DEPT = :NEW.ID_DEPT
        WHERE
            ID = :OLD.ID;
        UPDATE INFO_DEPT_ao
        SET
            PLATI = PLATI - :OLD.SALARIU
        WHERE
            ID = :OLD.ID_DEPT;
        UPDATE INFO_DEPT_ao
        SET
            PLATI = PLATI + :NEW.SALARIU
        WHERE
            ID = :NEW.ID_DEPT;
    END IF;
END;
/


SELECT *
FROM user_updatable_columns
WHERE table_name = UPPER('v_info_ao');

INSERT INTO INFO_DEPT_ao (ID, NUME_DEPT, PLATI)
VALUES (10, 'Nume dept', 0);

-- adaugarea unui nou angajat
SELECT * FROM info_dept_ao WHERE id=10;

INSERT INTO v_info_ao
VALUES (400, 'N1', 'P1', 3000,10, 'Nume dept', 0);


SELECT * FROM info_emp_ao WHERE ID=400;


SELECT * FROM info_dept_ao WHERE id=10;


-- modificarea salariului unui angajat
UPDATE v_info_ao
SET salariu=salariu + 1000
WHERE id=400;


SELECT * FROM info_emp_ao WHERE id=400;


SELECT * FROM info_dept_ao WHERE id=10;

INSERT INTO INFO_DEPT_ao (ID, NUME_DEPT, PLATI)
VALUES (90, 'Nume dept', 0);

-- modificarea departamentului unui angajat
SELECT * FROM info_dept_ao WHERE id=90;
UPDATE v_info_ao
SET id_dept=90
WHERE id=400;


SELECT * FROM info_emp_ao WHERE id=400;


SELECT * FROM info_dept_ao WHERE id IN (10,90);


-- eliminarea unui angajat
DELETE FROM v_info_ao WHERE id = 400;
SELECT * FROM info_emp_ao WHERE id=400;
SELECT * FROM info_dept_ao WHERE id = 90;
DROP TRIGGER trig5_ao;