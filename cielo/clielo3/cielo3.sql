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


--2--okk
WITH media_voli AS (
    SELECT AVG(Volo.durataMinuti) as media
    FROM Volo
)
SELECT v.comp, AVG(v.durataMinuti) as durata_media
FROM Volo v,media_voli
GROUP BY v.comp,media_voli.media
HAVING AVG(v.durataMinuti) > media_voli.media

--3--rivedere
WITH ma as (
    SELECT COUNT(ArrPart.arrivo) as numero
    FROM ArrPart
)
SELECT l.citta, COUNT(ap.arrivo) as numero_arrivi
FROM ArrPart ap,Aeroporto a, ma,LuogoAeroporto l 
WHERE l.aeroporto = a.codice and ap.arrivo = a.codice
GROUP BY l.citta
HAVING COUNT(ap.arrivo) > avg(ma.numero)

--4