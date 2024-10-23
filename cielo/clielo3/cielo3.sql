--1--okk
WITH ai as (

    SELECT a.codice as aeroporto_italia
    FROM LuogoAeroporto l
    JOIN Aeroporto a ON a.codice = l.aeroporto
    WHERE l.nazione = 'Italy'
    group by a.codice
)
SELECT c.nome, AVG(v.durataMinuti) as media_volo
FROM Compagnia c
JOIN Volo v ON v.comp = c.nome
JOIN ArrPart ap ON ap.codice = v.codice and ap.comp= c.nome
JOIN ai on ap.partenza = ai.aeroporto_italia
group by c.nome;


--2--rivdere
WITH media_voli AS (
    SELECT Volo.comp as nome,AVG(Volo.durataMinuti) as media
    FROM Volo
	group by Volo.comp
)
SELECT c.nome, AVG(Volo.durataMinuti) as durata_media
FROM  (
    SELECT Volo.comp as nome,AVG(Volo.durataMinuti) as media
    FROM Volo
	group by Volo.comp
) mv, Volo
JOIN Compagnia c ON mv.comp= c.nome 
GROUP BY v.comp
HAVING AVG(Volo.durataMinuti) > mv.media

--3--rivedere
SELECT l.citta, count(ap.arrivo) as numero_arrivi
FROM ArrPart ap,LuogoAeroporto l,(
    SELECT AVG(count(ArrPart.arrivo)) as arrivi_media 
    FROM ArrPart
    )apm
JOIN Aeroporto a ON l.aeroporto = a.codice
WHERE ap.arrivo = a.codice
GROUP BY l.citta 
HAVING count(ap.arrivo) > apm.arrivi_media

--4