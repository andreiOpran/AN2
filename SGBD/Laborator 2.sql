-- RECAPITULARE
-- 4

SELECT
    CATEGORY, COUNT(DISTINCT T.title_id)
FROM RENTAL_LBC R, TITLE_LBC T
WHERE T.TITLE_ID = R.TITLE_ID
GROUP BY CATEGORY
HAVING COUNT(*) = (
            SELECT
                MAX(COUNT(*))
            FROM TITLE_LBC T,RENTAL_LBC R
            WHERE T.TITLE_ID=R.TITLE_ID
            GROUP BY CATEGORY
        );



-- Laborator 2 --

-- Blocuri:
--     - anonime (se folosesc o singura data)
--     - neanonime (se pot apela de mai multe ori fara redeclarare)


-- Exercitiu 2

-- (afisare cu DBMS_OUTPUT.PUT_LINE(v_client_id);)

-- 300
-- N2
-- 300
-- N3
-- 1920
-- N2 N3

