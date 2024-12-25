SET SERVEROUTPUT ON;

-- e. o procedură prin care se actualizează cu o valoare dată ca parametru salariul unui angajat al cărui nume este dat ca parametru:
-- - se va verifica dacă valoarea dată pentru salariu respectă limitele impuse pentru acel job;
-- - dacă sunt mai mulţi angajaţi care au acelaşi nume, atunci se va afişa un mesaj corespunzător şi de asemenea se va afişa lista acestora;
-- - dacă nu există angajaţi cu numele dat, atunci se va afişa un mesaj corespunzător;

-- f. un cursor care obţine lista angajaţilor care lucrează pe un job al cărui cod este dat ca
-- parametru;

-- g. un cursor care obţine lista tuturor joburilor din companie;

-- h. o procedură care utilizează cele două cursoare definite anterior şi obţine pentru fiecare job
-- numele acestuia şi lista angajaţilor care lucrează în prezent pe acel job; în plus, pentru
-- fiecare angajat să se specifice dacă în trecut a mai avut sau nu jobul respectiv

CREATE OR REPLACE PACKAGE pachet_employees_ao AS

	-- e
	PROCEDURE set_salary(p_salary IN EMPLOYEES.SALARY%TYPE, p_first_name IN EMPLOYEES.FIRST_NAME%TYPE, p_last_name IN EMPLOYEES.LAST_NAME%TYPE);

	-- f
	FUNCTION get_employees_by_job(p_job_id IN JOBS.JOB_ID%TYPE) RETURN SYS_REFCURSOR;

	-- g
	FUNCTION get_jobs RETURN SYS_REFCURSOR;

	-- h
	PROCEDURE afisare_informatii_job;

END pachet_employees_ao;
/

CREATE OR REPLACE PACKAGE BODY pachet_employees_ao AS

	PROCEDURE set_salary(p_salary IN EMPLOYEES.SALARY%TYPE, p_first_name IN EMPLOYEES.FIRST_NAME%TYPE, p_last_name IN EMPLOYEES.LAST_NAME%TYPE) IS
	min_salariu JOBS.MIN_SALARY%TYPE;
	max_salariu JOBS.MAX_SALARY%TYPE;
	cont NUMBER(6);
	salariu_prea_mic EXCEPTION;
	salariu_prea_mare EXCEPTION;
	no_job EXCEPTION;
	no_employee EXCEPTION;
	too_many_employees EXCEPTION;

	BEGIN

		-- extragere salariu minim si maxim
		SELECT 
			MIN_SALARY, 
			MAX_SALARY
		INTO min_salariu, max_salariu
		FROM JOBS
		WHERE JOB_ID = (
			SELECT 
				JOB_ID 
			FROM EMP_AO WHERE FIRST_NAME = 'Alexander' AND LAST_NAME = 'Hunold'
			AND ROWNUM = 1
		);

		IF min_salariu = -1 OR max_salariu = -1 THEN
			RAISE no_job;
		END IF;
		IF p_salary < min_salariu THEN
			RAISE salariu_prea_mic;
		END IF;
		IF p_salary > max_salariu THEN
			RAISE salariu_prea_mare;
		END IF;


		-- verificare numar angajati
		SELECT 
			COUNT(*)
		INTO cont
		FROM EMP_AO
		WHERE FIRST_NAME = p_first_name AND LAST_NAME = p_last_name;

		IF cont = 0 THEN
			RAISE no_employee;
		END IF;
		IF cont > 1 THEN
			RAISE too_many_employees;
		END IF;

		-- actualizare salariu
		UPDATE EMP_AO
		SET SALARY = p_salary
		WHERE FIRST_NAME = p_first_name AND LAST_NAME = p_last_name;

		COMMIT;
		DBMS_OUTPUT.PUT_LINE('Salariul a fost actualizat cu succes');

		EXCEPTION
			WHEN salariu_prea_mic THEN
				DBMS_OUTPUT.PUT_LINE('Salariul introdus este prea mic');
			WHEN salariu_prea_mare THEN
				DBMS_OUTPUT.PUT_LINE('Salariul introdus este prea mare');
			WHEN no_job THEN
				DBMS_OUTPUT.PUT_LINE('Nu exista job pentru angajatul ' || p_first_name || ' ' || p_last_name);
			WHEN no_employee THEN
				DBMS_OUTPUT.PUT_LINE('Nu exista angajatul ' || p_first_name || ' ' || p_last_name);
			WHEN too_many_employees THEN
				DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati cu numele ' || p_first_name || ' ' || p_last_name);
				FOR inregistrare IN (
					SELECT 
						EMPLOYEE_ID, 
						FIRST_NAME, 
						LAST_NAME 
					FROM EMPLOYEES 
					WHERE FIRST_NAME = p_first_name AND LAST_NAME = p_last_name
				) 
				LOOP
					DBMS_OUTPUT.PUT_LINE('ID: ' || inregistrare.EMPLOYEE_ID || ', Nume: ' || inregistrare.FIRST_NAME || ' ' || inregistrare.LAST_NAME);
				END LOOP;
			WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('OTHER');

	END set_salary;


	FUNCTION get_employees_by_job(p_job_id IN JOBS.JOB_ID%TYPE) RETURN SYS_REFCURSOR IS
	rez SYS_REFCURSOR;
	
	BEGIN

		OPEN rez FOR
		SELECT * FROM EMPLOYEES 
		WHERE JOB_ID = p_job_id;
		
		RETURN rez;

	END get_employees_by_job;


	FUNCTION get_jobs RETURN SYS_REFCURSOR IS
	rez SYS_REFCURSOR;

	BEGIN

		OPEN rez FOR
		SELECT * FROM JOBS;

		RETURN rez;

	END get_jobs;


	PROCEDURE afisare_informatii_job IS
		job_cursor SYS_REFCURSOR;
		emp_cursor SYS_REFCURSOR;
		job JOBS%ROWTYPE;
		employee EMPLOYEES%ROWTYPE;
	BEGIN
		job_cursor := get_jobs;

		LOOP
			FETCH job_cursor INTO job;
			EXIT WHEN job_cursor%NOTFOUND;

			DBMS_OUTPUT.PUT_LINE('---------------------------------------');
			DBMS_OUTPUT.PUT_LINE('JOB TITLE: ' || job.JOB_TITLE);
			DBMS_OUTPUT.PUT_LINE('---------------------------------------');

			emp_cursor := get_employees_by_job(job.JOB_ID);

			LOOP
				FETCH emp_cursor INTO employee;
				EXIT WHEN emp_cursor%NOTFOUND;

				DBMS_OUTPUT.PUT_LINE(employee.FIRST_NAME || ' ' || employee.LAST_NAME);
			END LOOP;

			CLOSE emp_cursor;
		END LOOP;

		CLOSE job_cursor;
	END afisare_informatii_job;

END pachet_employees_ao;
/

BEGIN
	pachet_employees_ao.afisare_informatii_job;
END;
/

select 
	employee_id,
	first_name,
	last_name,
	salary
from emp_ao
where first_name = 'Alexander' and last_name = 'Hunold';

BEGIN
	pachet_employees_ao.set_salary(100, 'Alexander', 'Hunold');
	pachet_employees_ao.set_salary(10000000, 'Alexander', 'Hunold');
	pachet_employees_ao.set_salary(9500, 'Alexander', 'Hunold');
END;
/



