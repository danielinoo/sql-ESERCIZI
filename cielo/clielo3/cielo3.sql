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


--3--ok
--aa-> totale arrivo
with aa as (SELECT a.codice as ae,count(ap.arrivo) as nta
from ArrPart ap
JOIN Aeroporto a ON ap.arrivo = a.codice
group by a.codice
),
--cm--> media citta
cm as(
	SELECT avg(aa.nta) as numero
    FROM aa
    JOIN LuogoAeroporto la on la.aeroporto = aa.ae
    JOIN ArrPart ap on ap.arrivo = aa.ae
)
--calcolo citta sopra media
select la.citta, count(ap.arrivo) as numero
from cm,aa
JOIN LuogoAeroporto la on la.aeroporto = aa.ae
JOIN ArrPart ap on ap.arrivo = aa.ae
group by la.citta,cm.numero
having count(ap.arrivo) > cm.numero


	
--4