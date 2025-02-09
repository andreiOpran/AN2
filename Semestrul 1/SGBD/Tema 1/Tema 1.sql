-- 17 -- Folosind tabelul VEHICUL generati un script care sterge toate inregistrarile din acest tabel.
SET PAGESIZE 4000;
SET LINESIZE 4000;
SPOOL "C:\Users\andre\Desktop\Tema 1 SGBD\sterg_tabele.sql"
SELECT
    'DELETE FROM VEHICUL WHERE ID_VEHICUL =  ' || ID_VEHICUL || ';'
FROM VEHICUL;
SPOOL OFF;



-- 23 -- Folosind tabelul MOTOR generati un script pentru inserarea datelor in tabel.
SET PAGESIZE 4000;
SET LINESIZE 4000;
SPOOL "C:\Users\andre\Desktop\Tema 1 SGBD\inserare.sql"
SELECT
    'INSERT INTO MOTOR (ID_MOTOR, MARCA, MODEL) ' || 'VALUES (' || ID_MOTOR || ', '''|| MARCA ||''', '''||MODEL||''');'
FROM MOTOR;
SPOOL OFF;