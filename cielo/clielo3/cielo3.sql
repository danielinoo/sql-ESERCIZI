--1--controllo se funziona
WITH ai as (

    SELECT a.codice as aeroporto_italia
    FROM LuogoAeroporto l
    JOIN Aeroporto a ON a.codice = l.aeroporto
    WHERE l.nazione = 'Italia'
    group by a.codice
)
SELECT c.nome, AVG(v. durataMinuti) as media_volo
FROM Compagnia c
JOIN Volo v ON v.comp = c.nome
JOIN ArrPart ap ON ap.codice = v.codice and ap.comp= c.nome
JOIN ai on ap.partenza = ai.aeroporto_italia
group by c.nome;